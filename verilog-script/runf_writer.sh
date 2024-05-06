#!/bin/bash

########## Notice ########## 
#Please run this script from the "SIM DIRECTORY PATH"

#example of project directory) 
# project diretory includes		--> impl/ sim/ src/ testbench/
# simulation directory			--> sim/vcs/
# rtl files located in			--> src/rtl/
# testbench files located in	--> testbench/

#example of shell usage)
# shell> pwd
# path/to/your_project/sim/
# shell> ./runf_writer.sh
############################


# Config Variables
# You can edit here
# Modify it to suit your project diretory
rtl_path="src/rtl/"		#Location of your RTL files
tb_path="testbench/"	#Location of your TESTBENCH

# Script Variables
# Recommend not to edit here
curr_path=$(pwd)
rtl_path_prefix=""
tb_path_prefix=""

#Function for calculate relative path of function_argument from current path
function get_rel_path() { 
	local target=$1
	local search_path=$curr_path
	local abs_path=""
	local rel_path=""

	# Search logic for find path
	while [ "$search_path" != "/" ]; do
		
		#if found rtl_path
		if [ -d "$search_path/$target" ]; then
			abs_path="$search_path/$target"
			break
		fi
		
		#update search path
		cd ..
		search_path=$(pwd)
	done

	# if can't find path 
	if [ "$abs_path" == "" ]; then
		echo "Can't find RTL files"
		exit 
	fi

	# return to current path
	cd $curr_path

	# Save relavetive path of "rtl_path" from "current_path"
	rel_path=$(realpath --relative-to="$curr_path" "$abs_path")

	# return result
	echo $rel_path
} 

# get path prefix
rtl_path_prefix=$(get_rel_path $rtl_path)
tb_path_prefix=$(get_rel_path $tb_path)

# write run.f
#write +incdir+
echo "+incdir+./" > run.f
find $rtl_path_prefix -type d | sort | awk '{print "+incidr+" $0}' >> run.f
find $tb_path_prefix -type d | sort | awk '{print "+incidr+" $0}' >> run.f
echo >> run.f

#write *.vh in current directory
find -name "*.vh" >> run.f
echo >> run.f

#write rtl file path
find $rtl_path_prefix -type f -name "*.v" -o -name "*.sv" | sort >> run.f
echo >> run.f

#write tb file path
find $tb_path_prefix -type f -name "*.v" -o -name "*.sv" | sort >> run.f
echo >> run.f

