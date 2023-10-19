import os
import argparse

parser = argparse.ArgumentParser(description='Verilog Project Templete Creator')
parser.add_argument('p_name', help='project directory name')

args = parser.parse_args()
project_dir = args.p_name
vcs = project_dir + "/sim/vcs/"
src = project_dir + "/src/rtl/"
tb = project_dir + "/testbench/"

format_file_path = "~/Script/format/format_files/"
vcs_makefile = "vcs_Makefile"
tb_format = "tb_format.v"

make_makefile = "cp -r " + format_file_path+vcs_makefile + "sim/vcs/Makefile"
make_tb_format = "cp -r" + format_file_path+vcs_makefile + "testbench/testbench.v"

path = os.getcwd().replace("\\","/") + "/" + project_dir

if os.exists(project_dir): exit()

mkdir_vcs = "mkdir -p " + vcs
mkdir_src = "mkdir -p " + src
mkdir_tb = "mkdir -p " + tb

os.system(mkdir_vcs)
os.system(mkdir_src)
os.system(mkdir_tb)

os.system(make_makefile)
os.system(make_tb_format)