#!/bin/bash

# USAGE : ./RUN_TB {TB_FOLDER_NAME} {path_to_rtl} {ECHO_EN}

curr_TB=$1
rtl_DIRECTORY=$2
progress_msg=$3

test_bench_DIRECTORY=`pwd`/testbenches/$curr_TB

emptyChar=" "

if [ -d "$rtl_DIRECTORY/mips_cpu" ]
then
    cpuFile=$rtl_DIRECTORY/mips_cpu_bus.v
    files=${cpuFile}${emptyChar}`ls $rtl_DIRECTORY/mips_cpu/*.v`
else
    files=`ls $rtl_DIRECTORY/*.v`
fi

if [ "$progress_msg" = "1" ] 
then
    echo "Compiling: "${curr_TB}
fi

cd $test_bench_DIRECTORY 

iverilog -g2012 -Wall -s testing_tb -o $test_bench_DIRECTORY/testing_tb_out $test_bench_DIRECTORY/testing_tb.v $files

if [ "$progress_msg" = "1" ] 
then
    echo "Success!"
    echo "Running..."
fi

./testing_tb_out