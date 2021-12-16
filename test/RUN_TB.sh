#!/bin/bash

# USAGE : ./RUN_TB {TB_FOLDER_NAME} {path_to_rtl}

curr_TB=$1
rtl_DIRECTORY=$2

outcome=""
error=""

test_bench_DIRECTORY=`pwd`/testbenches/$curr_TB

emptyChar=" "

if [ -d "$rtl_DIRECTORY/mips_cpu" ]
then
    cpuFile=$rtl_DIRECTORY/mips_cpu_bus.v
    files=${cpuFile}${emptyChar}`ls $rtl_DIRECTORY/mips_cpu/*.v`
else
    files=`ls $rtl_DIRECTORY/*.v`
fi

cd $test_bench_DIRECTORY 

iverilog -g2012 -Wall -s testing_tb -o $test_bench_DIRECTORY/testing_tb_out $test_bench_DIRECTORY/testing_tb.v $files >/dev/null && ./testing_tb_out >/dev/null

if [ "$?" -eq "0" ]
then
    outcome="Pass"
else 
    error="Incorrect Output Value / Timeout"
    outcome="Fail"
fi

echo ${curr_TB}" "${curr_TB%_*}" "${outcome}" "${error}