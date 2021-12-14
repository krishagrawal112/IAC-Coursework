lui $t0, 0xBFC0
lui $t1, 0x1122
addiu $t1, $t1, 0x3344
sw $t1, 0x0100($t0)
lui $v0, 0x5566
addiu $v0, $v0, 0x7788
lwr $v0, 0x0100($t0) //Bit 0
sw $v0, 0x108($t0) //memory[66]  == 32'h55667711
lui $v0, 0x5566
addiu $v0, $v0, 0x7788
lwr $v0, 0x101($t0) //Bit 0, 1
sw $v0, 0x10C($t0) //memory[67]  == 32'h55661122
lui $v0, 0x5566
addiu $v0, $v0, 0x7788
lwr $v0, 0x102($t0) //Bit 0, 1, 2
sw $v0, 0x110($t0) //memory[68]  == 32'55112233
lui $v0, 0x5566
addiu $v0, $v0, 0x7788
lwr $v0, 0x103($t0) //Bit 0, 1, 2, 3
sw $v0, 0x114($t0) //memory[69]  == 32'h11223344
j 0x0