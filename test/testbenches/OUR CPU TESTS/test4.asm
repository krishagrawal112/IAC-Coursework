lui $t0, 0xBFC0
lui $t1, 0xBFC0
addiu, $t1, $t1, 0x0014
jr $t1
lui $v0, 0xFFFF
addiu $v0, $v0, 0x0001
addiu $t0, $t0, 0x0028
jalr $v0, $t0
lui $v0, 0xFFFF
j 0x0
addiu $v0, $v0, 0x0004
lui $t2, 0xBFC0
addiu $t2, $t2, 0x0020
jalr $v0, $t2
