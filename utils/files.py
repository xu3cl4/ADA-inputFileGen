# import built-in modules 
from pathlib import Path

import pandas as pd 


FPATH = Path(__file__)
PATH_recharge = FPATH.parent.parent.joinpath('recharge_data')
PATH_prep = PATH_recharge.joinpath('prep.csv')
PATH_ET = PATH_recharge.joinpath('ET.csv')

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

    tpl_str = tpl_str.replace(f"@{idx}@", idx)

    # replace the parameters (except recharge), using the param_map
    for key in param_map:
        tpl_str = tpl_str.replace(key, param_formatter(param_map[key]))

    # write to a xml file 
    fname = dout.joinpath(f"farea-full_nem{idx}.in")
    with open(fname, "w") as fout:
        fout.writelines(tpl_str)
    
    return 

def create_xml(template_xml, param_map, idx, dout):
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

    tpl_str = tpl_str.replace("@idx@", idx)

    # replace the parameters (except recharge), using the param_map
    for key in param_map:
        if key == '@ET_factor@': continue 
        tpl_str = tpl_str.replace(key, param_formatter(param_map[key]))

    # replace recharge value 
    factor = param_map['@ET_factor@'] 
    if factor is not None:
        '''time, prep'''
        df_prep = pd.read_csv(FPATH_prep)
        '''time, et'''
        df_et = pd.read_csv(FPATH_ET) 
        
        matched = df_prep.merge(df_et, how='inner', on='time')
        matched['recharge'] = (matched['prep'] - factor*matched['et'])
        
        ref_1955 = 6.16635504e+10 
        ref_1989 = 6.27365088e+10
        month = 2.592e+06

        # compute the timestamps 
        matched['Time'] = pd.to_datetime(matched["Time"], format="%Y/%m")
        matched['Timestamp'] = ( (matched['Time'].dt.year - 1955)*12 + matched['Time'].dt.month )*month + ref_1955 
        
        r_right, r_left, r_seepage = '', '', ''
        for idx, row in matched.iterrows():
            r_right += f'<seepage_face function="constant" start="{row["Timestamp"]}" inward_mass_flux="{row["recharge"]}"\n' 
            r_left += f'<inward_mass_flux function="constant" start="{row["Timestamp]}" value="{row["recharge"]}"\n'
            if row["Timestamp"] >= ref_1989: 
                r_seepage += f'<inward_mass_flux function="constant" start="{row["Timestamp]}" value="{row["recharge"]/1000}"\n'
        
        tpl_str = tpl_str.replace("@r_right@", r_right)
        tpl_str = tpl_str.replace("@r_left@", r_left)
        tpl_str = tpl_str.replace("@r_seepage@", r_seepage)

    # write to a xml file 
    fname = dout.joinpath(f"sim{idx}.xml")
    with open(fname, "w") as fout:
        fout.writelines(tpl_str)

    return 

def create_files(template_xml, template_pflo, param_map, idx, dout):

    # create xml
    create_xml(template_xml, param_map["amanzi"], idx, dout)

    # create dat file for pflotran 
    if template_pflo is not None:
        create_pflo(template_pflo, param_map["pflo"], idx, dout)
    
    return 
