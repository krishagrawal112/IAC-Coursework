lui $t1, 0xBFC0
lui $t0, 0xB000
sra $v0, $t0, 0x1E
sw $v0, 0x100($t1)
lui $t0, 0x7000
sra $v0, $t0, 0x1E
j 0x0