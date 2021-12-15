lui $t0, 0xBFC0
addiu $t1, $t1, 0x00f1
addiu $t2, $t2, 0x0008
sllv $v0, $t1, $t2
sw $v0, 0x4($t0)
lui $t1, 0xFEE0
sllv $v0, $t1, $t2
j 0x0