lui $t0, 0xBFC0
lui $t1, 0x1122
addiu $t1, $t1, 0x3344
addiu $v0, $v0, 0xEEFF
sw $t1, 0x100($t0)
sb $v0, 0x100($t0) //memory[64]  == 32'hFF223344
sw $t1, 0x100($t0)
sb $v0, 0x101($t0) //memory[64]  == 32'h11FF3344
sw $t1, 0x100($t0)
sb $v0, 0x102($t0) //memory[64]  == 32'h1122FF44
sw $t1, 0x100($t0)
sb $v0, 0x103($t0) //memory[64]  == 32'h112233FF
