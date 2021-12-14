lui $t0, 0xBFC0
lui $t1, $t1, 0xFFFF
addiu $t1 $t1, 0xFFFF
addiu $t2, $t2, 0x0007
mult $t1, $t2
mfhi $v0
mflo $v0
multu $t1, $t2
mfhi $v0
mflo $v0
lui $t1, $t1, 0x8888
addiu $t1 $t1, 0x888B
lui $t2, $t2, 0x4444
addiu $t2, $t2, 0x4444
divu $t1, $t2
mfhi $v0
mflo $v0
addiu $t1, $t1, 0x0003
div $t1, $t2
mfhi $v0
mflo $v0
j 0x0