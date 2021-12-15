lui $t1, 0xBFC0
lui $t0, 0xB000
addiu $t2, $t2, 0x001E
sra $v0, $t0, $t2
sw $v0, 0x100($t1)
lui $t0, 0x7000
addiu $t2, $t2, 0x001E
sra $v0, $t0, $t2
j 0x0