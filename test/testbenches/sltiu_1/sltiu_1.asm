lui $t0, 0xBFC0
addiu $t1, $t1, 0x0002
sltiu $v0, $t1, 0x0003
sw $v0, 0x100($t0) //1
sltiu $v0, $t1, 0x0001
sw $v0, 0x104($t0) //0
sltiu $v0, $t1, 0x8000
sw $v0, 0x108($t0) //1
lui $t2, 0xFFFF
addiu, $t2, $t2, 0xF000
sltiu $v0, $t2, 0x8000
sw $v0, 0x110($t0) //0
sltiu $v0, $t2, 0xFF00
sw $v0, 0x114($t0) //1
j 0x0
sltiu $v0, $t2, 0xF000 //0
