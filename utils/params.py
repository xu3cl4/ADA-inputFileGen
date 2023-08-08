# import from built-in modules 
from pathlib         import Path
from scipy.stats.qmc import LatinHypercube as LHS, scale

import json
import numpy  as np
import pandas as pd
import yaml

FPATH = Path(__file__)
PATH_par = FPATH.parent.parent.joinpath('para_maps')

def getParams_yml(nsim, fin, seed, path_to_csv):
    ''' read from a .yaml/.yml file for the range of each parameter 
        the format of .yaml file is 
            amanzi: 
                par1:
                    low:
                    up:
                par2:
                    ...
            pflo:
                par1:
                    low:
                    up:
                par2:
                    ...
        then output a list of dictionaries (par: val) whose length is nsim 
    '''
    with open(fin, 'r') as f: 
        params_ranges = yaml.safe_load(f)   
        
        amanzi_keys, pflo_keys = [], [] 
        l_bounds, u_bounds = [], []
        
        # read the parameter for an amanzi (.xml) input file
        amanzi = params_ranges['amanzi']
        npar_amanzi = len(amanzi)
        for par in amanzi.keys():
            amanzi_keys.append(par)
            l_bounds.append(amanzi[par]['low'])
            u_bounds.append(amanzi[par]['up'])

        # read the parameter for a pflotran input file 
        pflo = params_ranges['pflo']
        for par in pflo.keys():
            pflo_keys.append(par)
            l_bounds.append(pflo[par]['low'])
            u_bounds.append(pflo[par]['up'])
        
        # generate samples from the parameter space, using the Latin Hypercube sampling
        sampler = LHS(d = npar_amanzi + len(pflo), seed=seed)
        sample = sampler.random(n=nsim)
        sample_scaled = scale(sample, l_bounds, u_bounds)

        def make_map(pars):
            mapping = {}
            mapping['amanzi'] = dict(zip(amanzi_keys, pars[:npar_amanzi]))
            mapping['pflo'] = dict(zip(pflo_keys, pars[npar_amanzi:]))
            return mapping

        # generate a list of parameter maps, length nsim
        maps = np.apply_along_axis(make_map, 1, sample_scaled).tolist()
        
        # save the parameters 
        
        fname = PATH_par.joinpath(f'{path_to_csv.stem}_paras.json')
        '''
        with open(fname, 'a') as f:
            for i, m in enumerate(maps):
                f.write(f'sample {i+1}\n')
                json.dump(m, f)
                f.write('\n')
        ''' 

        maps_amanzi = map(lambda x: x['amanzi'], maps)
        maps_pflo   = map(lambda x: x['pflo'],   maps)

        para_amanzi = pd.DataFrame(maps_amanzi)
        para_amanzi.columns = list(amanzi.keys()) 
        para_pflo   = pd.DataFrame(maps_pflo)
        para_pflo.columns   = list(pflo.keys())
        para        = pd.concat([para_amanzi, para_pflo], axis=1, join='inner')
        fname_csv   = fname.with_suffix('.csv')
        para.to_csv(fname_csv, index=False)
        
        return maps 

def getParams_csv(fin):
    
    params = pd.read_csv(fin)
    params_amanzi = df.columns[~params.columns.str.contains("seepage")]
    params_pflo   = df.columns[params.columns.str.contains("seepage")] 

    def make_map(row):
        mapping = {}
        mapping['amanzi'] = dict(zip(params_amanzi, row[params_amanzi]))
        mapping['amanzi'] = dict(zip(params_pflo, row[params_pflo]))
        return mapping 

    maps = (params.apply(make_map, axis=1)).tolist()
    return maps

def getParams(nsim, fin, seed, path_to_csv):

    dispatch = {
            '.yml':  lambda n, f, s, p: getParams_yml(n, f, s, p), 
            '.yaml': lambda n, f, s, p: getParams_yml(n, f, s, p), 
            '.csv':  lambda n, f, s, p: getParams_csv(f)
            }
    
    return dispatch[fin.suffix](nsim, fin, seed, path_to_csv)

