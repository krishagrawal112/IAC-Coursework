lui $t0, 0xBFC0
lui $t1, 0x1122
addiu $t1, $t1, 0x3344
sw $t1, 0x0100($t0) //MSB == 0
lui $t2, 0xFFEE 
addiu $t2, $t2, 0xDDCC 
sw $t2, 0x104($t0) //MSB == 1 
lb $v0, 0x0100($t0) //Bit 0
sw $v0, 0x108($t0) //memory[66]  == 32'h00000011
lb $v0, 0x101($t0) //Bit 1
sw $v0, 0x10C($t0) //memory[67]  == 32'h00000022
lb $v0, 0x102($t0) //Bit 2
sw $v0, 0x110($t0) //memory[68]  == 32'h00000033
lb $v0, 0x103($t0) //Bit 3
sw $v0, 0x114($t0) //memory[69]  == 32'h00000044
lb $v0, 0x104($t0) //Bit 0
sw $v0, 0x118($t0) //memory[70]  == 32'hFFFFFFFF
lb $v0, 0x105($t0) //Bit 1
sw $v0, 0x11C($t0) //memory[71]  == 32'hFFFFFFEE
lb $v0, 0x106($t0) //Bit 2
sw $v0, 0x120($t0) //memory[72]  == 32'hFFFFFFDD
lb $v0, 0x107($t0) //Bit 3
sw $v0, 0x124($t0) //memory[73]  == 32'hFFFFFFCC
j 0x0