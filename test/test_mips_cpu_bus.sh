
# USAGE : ./test_mips_cpu_bus.sh {PATH_TO_RTL}

rtl_DIRECTORY=$1

echo "Mult Test"
./RUN_TB.sh TB_MULT $rtl_DIRECTORY 0
#./RUN_TB.sh FIBONACCI_TB $rtl_DIRECTORY 0