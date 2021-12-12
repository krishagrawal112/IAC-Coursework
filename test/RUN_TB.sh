#!/bin/bash

curr_TB=$1

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

echo "Compiling: "${curr_TB}

cd $test_bench_DIRECTORY 

iverilog -g2012 -Wall -s testing_tb -o $test_bench_DIRECTORY/testing_tb_out $test_bench_DIRECTORY/testing_tb.v $files

echo "Success!"
echo "Running..."

./testing_tb_out