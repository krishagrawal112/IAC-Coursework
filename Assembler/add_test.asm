lw $zero, $t0, 0000H
addiu $zero, $t1, 0008H
add $t0, $t1, $v0
lw $zero, $t3, 0004H
or $t0, $t3, $v0
bltzal $v0, 0001H
addiu $zero, $v0, 0001H
addiu $zero, $v0, 0002H
addiu $zero, $v0, 0003H
add $ra, $zero, $v0