lui $t0, 0xBFC0
lui $t1, 0xFe53
addiu $t1, $t1 0xBAFE
addu $v0, $t3, $t1
lui $t2, 0xE436
addiu $t2, $t2 0xFF67
addu $v0, $t3, $t2
mult $t2,$t1
mflo $v0
sw $v0 0x100 ($t0)
mfhi $v0
j 0x0
sw $v0, 0x104 ($t0)