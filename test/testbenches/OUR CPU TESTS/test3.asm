lui $t0, 0xBFC0
lui $v0, 0x1111
addiu $v0, $v0, 0x2222
addu $v0, $v0, $v0
lui $t1, 0x1111
subu $v0, $v0, $t1
ori $v0, $v0, 0x0001
andi $v0, $v0, 0x4444
xori, $v0, $v0, 0xFFFF
addiu $t1, $t1, 0x0001
or $v0, $v0, $t1
addiu $t1, $t1, 0x0004
and $v0, $v0, $t1
xor $v0, $v0, $t1
addu $t2, $v0, $zero
sll $v0, $v0, 0x1B
sra $v0, $v0, 0x2
srav, $v0, $v0, $t2
srl $v0, $v0, 0x4
srlv $v0, $v0, $t2
sllv $v0, $v0, $t2
sll $t1, $t1, 0x3
slt $v0, $t1, $t2
sltu $v0, $t1, $t2
slti $v0, $t1, 0xF000
sltiu $v0, $t1, 0xF000
j 0x0