# import built-in modules 
from pathlib import Path

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
    if param_map['@ET_factor@'] is not None:
        pass 

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
