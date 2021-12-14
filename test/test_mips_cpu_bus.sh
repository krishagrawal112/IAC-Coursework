
# USAGE : ./test_mips_cpu_bus.sh {PATH_TO_RTL}

rtl_DIRECTORY=$1

for foldername in `ls ./testbenches`
do
    if [[ "$foldername" == *"_"* ]] 
    then
        ./RUN_TB.sh "$foldername" $1 || echo "$foldername""compilation error"
    fi
done