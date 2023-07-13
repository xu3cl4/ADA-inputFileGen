# import built-in modules 
from pathlib import Path

FPATH = Path(__file__)
PATH_recharge = FPATH.parent.parent.joinpath('recharge_data')
PATH_prep = PATH_recharge.joinpath('prep.csv')
PATH_ET = PATH_recharge.joinpath('ET.csv')

def create_xml(template, param_map, idx, dout):
    ''' the workflow of the helper function:
        - read the template as a long string 
        - replace the parameters in the string, using the parameter map 
        - if evapotranspiration factor is set, replace the recharge parameter 
        - write the modifed string to a xml file in dout 
    '''

    # read the template file 
    tpl = open(template, 'rt') 
    tpl_str = tpl.read()
    tpl.close()

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
