addiu $t0, 0x0001
addiu $t1, 0x0002
slt $v0, $t0, $t1 
sw $v0, 0x100($t0)
slt $v0, $t1, $t0
sw $v0, 0x104($t0)
lui $t0, 0x8000
slt $v0, $t0, $t1 
sw $v0, 0x108($t0)
slt $v0, $t1, $t0
sw $v0, 0x10C($t0)
lui $t1, 0x9000
slt $v0, $t0, $t1 
sw $v0, 0x110($t0)
slt $v0, $t1, $t0
sw $v0, 0x114($t0)
lui $t0, 0x9000
slt $v0, $t1, $t0
