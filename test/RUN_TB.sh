#!/bin/bash

curr_TB=$1
progress_msg=$2

base_DIRECTORY=`dirname \`pwd\``
test_bench_DIRECTORY=$base_DIRECTORY/test/testbenches/$curr_TB
rtl_DIRECTORY=$base_DIRECTORY/rtl

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