
# USAGE : ./test_mips_cpu_bus.sh {PATH_TO_RTL}

rtl_DIRECTORY=$1

./RUN_TB.sh addiu_1 $1
./RUN_TB.sh addiu_2 $1