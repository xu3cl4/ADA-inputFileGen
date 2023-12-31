# import built-in modules 
from pathlib import Path

import pandas as pd 


FPATH = Path(__file__)
PATH_recharge = FPATH.parent.parent.joinpath('recharge_data')

PATH_prcp = PATH_recharge.joinpath('prcp.csv')
PATH_ET = PATH_recharge.joinpath('et.csv')

def create_pflo(template_pflo, param_map, idx, dout):
    ''' the workflow of the helper function:
        - read the template_pflo as a long string 
        - replace the parameters in the string, using the parameter map 
        - write the modifed string to a .in file in dout 
    '''
    # read the template_pflo file 
    tpl = open(template_pflo, 'rt') 
    tpl_str = tpl.read()
    tpl.close()

    tpl_str = tpl_str.replace(f"@{idx}@", str(idx))

    # replace the parameters (except recharge), using the param_map
    for key in param_map:
        tpl_str = tpl_str.replace(key, str(param_map[key]))

    # write to a xml file 
    fname = dout.joinpath(f"farea-full_nem{idx}.in")
    with open(fname, "w") as fout:
        fout.writelines(tpl_str)
    
    return 

def create_xml(template_xml, param_map, idx, dout, year):
    ''' the workflow of the helper function:
        - read the template_xml as a long string 
        - replace the parameters in the string, using the parameter map 
        - if evapotranspiration factor is set, replace the recharge parameter 
        - write the modifed string to a xml file in dout 
    '''
    # read the template_xml file 
    tpl = open(template_xml, 'rt') 
    tpl_str = tpl.read()
    tpl.close()

    tpl_str = tpl_str.replace("@idx@", str(idx))

    # replace the parameters (except recharge), using the param_map
    for key in param_map:
        if key == '@ET_factor@': continue 
        
        tpl_str = tpl_str.replace(key, str(param_map[key]))
        if key == '@r_hist@':
            tpl_str = tpl_str.replace('@r_after@', str(param_map[key]/1000))

    # replace recharge value 
    factor = param_map['@ET_factor@'] if '@ET_factor' in param_map else None
    if factor is not None:
        # Date, prcp
        df_prcp = pd.read_csv(PATH_prcp)
        # Date, et
        df_et = pd.read_csv(PATH_ET) 
        
        matched = df_prcp.merge(df_et, how='inner', on='Date')
        matched['recharge'] = (matched['prcp'] - factor*matched['et'])
        
        ref_1955 = 6.16635504e+10 
        ref_1989 = 6.27365088e+10
        month = 2.592e+06

        # compute the timestamps 
        if year:
            matched['Date'] = pd.to_datetime(matched["Date"], format="%Y")
            matched['Timestamp'] = (matched['Date'].dt.year - 1955)*12*month + ref_1955 
        else:
            matched['Date'] = pd.to_datetime(matched["Date"], format="%Y-%m-%d")
            matched['Timestamp'] = ( (matched['Date'].dt.year - 1955)*12 + matched['Date'].dt.month - 1)*month + ref_1955 
        
        r_right, r_left, r_seepage = '', '', ''
        for ind, row in matched.iterrows():
            s = f'\t\t<inward_mass_flux function="constant" start="{row["Timestamp"]}" value="{row["recharge"]}"/>\n'
            r_right += f'\t\t<seepage_face function="constant" start="{row["Timestamp"]}" inward_mass_flux="{row["recharge"]}"/>\n' 
            r_left += s
            if row["Timestamp"] >= ref_1989: 
                r_seepage += f'\t\t<inward_mass_flux function="constant" start="{row["Timestamp"]}" value="{row["recharge"]/1000}"/>\n'
        
        tpl_str = tpl_str.replace("@r_right@", r_right)
        tpl_str = tpl_str.replace("@r_left@", r_left)
        tpl_str = tpl_str.replace("@r_seepage@", r_seepage)

    # write to a xml file 
    fname = dout.joinpath(f"sim{idx}.xml")
    with open(fname, "w") as fout:
        fout.writelines(tpl_str)

    return 

def create_files(template_xml, template_pflo, param_map, idx, dout, year=False):
    # modify recharge data path if the user intends to use yearly data
    if year: 
        global PATH_prcp, PATH_ET
        PATH_prcp = PATH_prcp.parent.joinpath('prcp_year.csv')
        PATH_ET = PATH_ET.parent.joinpath('et_year.csv')

    # create xml
    create_xml(template_xml, param_map["amanzi"], idx, dout, year)

    # create dat file for pflotran 
    if template_pflo is not None:
        create_pflo(template_pflo, param_map["pflo"], idx, dout)
    
    return 
