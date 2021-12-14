
# USAGE : ./test_mips_cpu_bus.sh {PATH_TO_RTL}

rtl_DIRECTORY=$1

./RUN_TB.sh addiu_1 $1
./RUN_TB.sh addiu_2 $1
./RUN_TB.sh addu_1 $1
./RUN_TB.sh addu_2 $1
./RUN_TB.sh and_1 $1
./RUN_TB.sh and_2 $1
./RUN_TB.sh andi_1 $1
./RUN_TB.sh andi_2 $1
./RUN_TB.sh div_1 $1
./RUN_TB.sh div_2 $1
./RUN_TB.sh divu_1 $1
./RUN_TB.sh div_2 $1
./RUN_TB.sh lb_1 $1
./RUN_TB.sh lb_2 $1
./RUN_TB.sh lbu_1 $1
./RUN_TB.sh lbu_2 $1
./RUN_TB.sh lh_1 $1