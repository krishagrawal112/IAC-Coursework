lui $t0, 0xBFC0
lui $t1, 0x1122
addiu $t1, $t1, 0x3344
addiu $v0, $v0, 0xEEFF
sw $t1, 0x100($t0)
sh $v0, 0x100($t0) //memory[64]  == 32'hEEFF3344
sw $t1, 0x104($t0)
sh $v0, 0x106($t0) //memory[65]  == 32'h1122EEFF
j 0x0