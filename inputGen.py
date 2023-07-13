# import from built-in modules 
from argparse import ArgumentParser, RawTextHelpFormatter as RT
from pathlib  import Path
from joblib   import Parallel, delayed


# import from personal modules 
from utils.params import getParams
from utils.xml    import create_xml


FPATH = Path(__file__)
DIR = FPATH.parent

def getArguemnts():
    ''' parse the command-line interface
        the command line takes three required arguments  

        -n : number of xml files
        -ipt: the file path to the parameter map
        -tpl: the xml template 
        -opt: the directory to output the xml files 
    '''  
    parser = ArgumentParser(formatter_class=RT)
    parser.add_argument('n',        type = int, help="the number of parameter samples, each of which leads to a xml file")
    parser.add_argument('ipt',      type = str, help="the file path to a .yaml/yml parameter map in the parameters folder")
    parser.add_argument('tpl',      type = str, help="the file path to a xml template in the template folder")
    parser.add_argument('opt',      type = str, help="the directory to store xml files")
    parser.add_argument('-s',       type = int, help="the seed to set up the samples from the parameter space", default=1217)
    parser.add_argument('-smethod', type = str, help=
        '''
        the sampling method over the parameter space: 
            LHS (Latin Hypercube)
            U (uniform)
        ''', default="LHS")

    return parser.parse_args()

def main():
    ''' the basic structure of the python scripts '''  
    args = getArguments()

    n   = args.n
    ipt = DIR.joinpath(args.ipt)
    tpl = DIR.joinpath(args.tpl)
    opt = DIR.joinpath(args.opt)

    # sample from the parameter space 
    # params is a list of parameter maps
    params = getParams(n, ipt, args.s, args.smethod)

    # use parallelism to write xml files 
    Parallel(n_jobs=-1, verbose=1)\
            (delayed(create_xml)(
                    template=tpl, param_map=params[i], idx=i, dout=opt
                )
            for i in range(n)
        )
