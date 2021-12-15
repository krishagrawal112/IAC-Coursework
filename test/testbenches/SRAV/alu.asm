lui $t0, 0xBFC0
lui $t1, 0xFC32
addiu $t2, $t2, 0x8
srav $v0, $t1, $t2
sw $v0,0x4 ($t0)
lui $t3 0x701f
srav $v0, $t3, $t2
j 0x0