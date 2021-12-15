lui $t0 0xBFC0

lui $t1, 0x84f1
addiu $t1,$t1, 0x89fb
slti $v0, $t1, 0x8000
sw $v0, 0x4 ($t0) //1

lui $t2, 0x8000
addiu $t2, $t2, 0x0001
slti $v0, $t2, 0x7000 
sw $v0, 0x8 ($t0) //1

lui $t3, 0x0789
addiu $t3, $t3 , 0x1000
slti $v0, $t3, 0x8000
sw $v0, 0xC ($t0) //0

addiu $t4, 0x5f62
slti $v0, $t4, 0x6711
sw $v0,0x10 ($t0) //1

addiu $t5, 0x0230
slti $v0, $t5, 0x0230
sw $v0, 0x14 ($t0)//0

slti $v0, $t5, 0x8000
sw $v0, 0x18 ($t0)//0

slti $v0,$t5, 0x0231
sw $v0 , 0x1C ($t0)//1

j 0x0