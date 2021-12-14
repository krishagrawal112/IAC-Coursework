lui $t0, 0xBFC0
lui $v0, 0x1111
addiu $v0, $v0, 0x2222
sw $v0, 0x0100($t0)
addu $v0, $v0, $v0
sw $v0, 0x0104($t0)
lui $t1, 0x1111
subu $v0, $v0, $t1
sw $v0, 0x0108($t0)
ori $v0, $v0, 0x0001
sw $v0, 0x010C($t0)
andi $v0, $v0, 0x4444
sw $v0, 0x0110($t0)
xori, $v0, $v0, 0xFFFF
sw $v0, 0x0114($t0)
addiu $t1, $t1, 0x0001
or $v0, $v0, $t1
sw $v0, 0x0118($t0)
addiu $t1, $t1, 0x0004
and $v0, $v0, $t1
sw $v0, 0x011C($t0)
xor $v0, $v0, $t1
sw $v0, 0x0120($t0)
addiu $t2, $t2, 0x0001 
sll $v0, $v0, 0x1D
sw $v0, 0x0124($t0)
sra $v0, $v0, 0x2
sw $v0, 0x0128($t0)
srav, $v0, $v0, $t2
sw $v0, 0x012C($t0)
srl $v0, $v0, 0x4
sw $v0, 0x0130($t0)
srlv $v0, $v0, $t2
sw $v0, 0x0134($t0)
sllv $v0, $v0, $t2
sw $v0, 0x0138($t0)
sll $t1, $t1, 0x3
slt $v0, $t1, $t2
sw $v0, 0x013C($t0)
sltu $v0, $t1, $t2
sw $v0, 0x0140($t0)
slti $v0, $t1, 0xF000
sw $v0, 0x0144($t0)
sltiu $v0, $t1, 0xF000
sw $v0, 0x0148($t0)
j 0x0