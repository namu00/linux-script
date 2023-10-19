import os

def init_path(sim_abs_path):
    os.chdir(sim_abs_path)

def abspath(path):
    try:
        ret_str = os.path.abspath(path)
        ret_str = ret_str.replace("\\", "/")
        ret_str += "/"
        
        return ret_str
    except:
        print("[ERROR] There are no directory ", path)
        exit()

def relpath(target, start):
    try:
        ret_str = os.path.relpath(target, start)
        ret_str = ret_str.replace("\\", "/")
        ret_str += "/"
        
        return ret_str
    except:
        print("[ERROR] There are no directory ", target)
        print("Or ", start)
        exit()

def ret_dir_list(path):
    ret_list = []
    with os.scandir(path) as dir_info:
        for ford in dir_info:
            if (ford.is_dir()):
                ret_list.append((ford.path) + "/")
            else:
                continue
            
    return ret_list

def ret_file_list(path):
    ret_list = []
    with os.scandir(path) as dir_info:
        for ford in dir_info:
            if(ford.is_file()):
                ret_list.append(ford.path)
    
    return ret_list


def ret_runf_str(sim_path, src_path, tb_path):
    incdir = "+incdir+"
    LF = "\n"
    EOD = (LF *1) #End Of Description
    
    #1. incdir list write
    runf_str = (
        incdir + sim_path + LF
        +incdir + src_path + LF
        +incdir + tb_path + LF
    ) 
    
    src_dir_list = ret_dir_list(src_path)
    
    for dir in src_dir_list:
        runf_str +=(
            incdir + dir + LF
        )
    
    runf_str += EOD
    
    #2. verilog source file path write
    for dir_in_src in src_dir_list:
        file_list = ret_file_list(dir_in_src)
        
        for file_path in file_list:
            runf_str += (
                file_path + LF
            )
        
        runf_str += EOD
    
    src_list = ret_file_list(src_path)
    for file_path in src_list:
        runf_str += (
            file_path + LF
        )
    
    runf_str += EOD
    
    #3. verilog testbench file path write
    src_list = ret_file_list(tb_path)
    for file_path in src_list:
        runf_str += (
            file_path + LF
        )
    
    runf_str += EOD
    
    return runf_str

if __name__ == "__main__":               
    SIM_PATH = "sim/vcs"
    SRC_PATH = "src/rtl"
    TB_PATH = "testbench"

    PRJ_ABS_PATH = abspath("./")
    SIM_ABS_PATH = abspath(SIM_PATH)
    SRC_ABS_PATH = abspath(SRC_PATH)
    TB_ABS_PATH = abspath(TB_PATH)

    SRC_REL_PATH_FROM_SIM = relpath(SRC_ABS_PATH, SIM_ABS_PATH)
    TB_REL_PATH_FROM_SIM = relpath(TB_ABS_PATH, SIM_ABS_PATH)

    sim_path = "./"
    src_path = SRC_REL_PATH_FROM_SIM
    tb_path = TB_REL_PATH_FROM_SIM 
    
    runf_str = ""

    init_path(SIM_ABS_PATH)
    runf_str = ret_runf_str(sim_path, src_path, tb_path)
    
    with open("run.f", 'w', encoding='utf-8') as fp:
        fp.writelines(runf_str)
    
    print("---run.f Contents---\n")
    print(runf_str)