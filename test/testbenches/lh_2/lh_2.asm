lui $t0, 0xBFC0
lui $t1, 0x1122
addiu $t1, $t1, 0x3344
sw $t1, 0x0100($t0) //MSB == 0
lui $t2, 0xFFEE 
addiu $t2, $t2, 0xDDCC 
sw $t2, 0x104($t0) //MSB == 1 
lh $v0, 0x0100($t0) //Word 0
sw $v0, 0x108($t0) //memory[66]  == 32'h00001122
lh $v0, 0x102($t0) //Word 1
sw $v0, 0x10C($t0) //memory[67]  == 32'h00003344
lh $v0, 0x104($t0) //Word 0
sw $v0, 0x110($t0) //memory[68]  == 32'hFFFFFFEE
lh $v0, 0x106($t0) //Word 1
j 0x0
sw $v0, 0x114($t0) //memory[69]  == 32'hFFFFDDCC