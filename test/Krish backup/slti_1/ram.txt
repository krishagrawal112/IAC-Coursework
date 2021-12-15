lui $t0, 0xBFC0
addiu $t1, $t1, 0x0002
slti $v0, $t1, 0x0003
sw $v0, 0x100($t0) //1
slti $v0, $t1, 0x0001
sw $v0, 0x104($t0) //0
slti $v0, $t1, 0x8000
sw $v0, 0x108($t0) //0
slti $v0, $t1, 0x8000
sw $v0, 0x10C($t0) //1
lui $t1, 0xFFFF
addiu, $t1, $t1, 0xF000
slti $v0, $t1, 0x8000
sw $v0, 0x110($t0) //0
slti $v0, $t1, 0xFF00
sw $v0, 0x114($t0) //1
slti $v0, $t1, 0xF000 //0
