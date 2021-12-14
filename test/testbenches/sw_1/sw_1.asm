lui $t0, 0xBFC0
lui $t1, 0x1122
addiu $t1, $t1, 0x3344
sw $t1, 0x0100($t0) //memory[64] == 32'h11223344
j 0x0