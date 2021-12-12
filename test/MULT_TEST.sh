#!/bin/bash

curr_TB=$1

base_DIRECTORY=`dirname \`pwd\``
test_bench_DIRECTORY=$base_DIRECTORY/test/testbenches/$curr_TB
rtl_DIRECTORY=$base_DIRECTORY/rtl

if [ -d `$rtl_DIRECTORY/mips_cpu`]
then
    echo exists
else
    echo doesnt
fi

echo $test_bench_DIRECTORY

#iverilog -g2012 -Wall -s testing_tb -o $test_bench_DIRECTORY/testing_tb_out $test_bench_DIRECTORY/testing_tb.v