lui $t0, 0x1111
addiu $t0, $t0, 0x2222
lui $t1, 0x2222
addiu $t1, $t1, 0x1111
addu $v0, $t1, $t0
j 0x0