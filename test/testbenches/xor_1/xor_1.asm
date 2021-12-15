lui $t0, 0x1000
addiu $t0, $t0, 0x6F00
lui $t1, 0x1011
addiu $t1, $t1, 0xF050
xor $v0, $t1, $t0
j 0x0