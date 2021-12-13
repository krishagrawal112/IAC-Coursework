addiu $s3 $zero BFC0H
sll $s3 $s3 0010H
addiu $s3 $s3 001CH #Setting s3 to the address of line 8
addiu $t0 $zero 0010H #T0 is the iteration variable
addiu $s0 $zero 0001H
addiu $s1 $zero 0001H
addiu $s2 $zero 0001H #Setting theese values all to 1
BLTZ $t0 0006H  #Loop condition, if conditions are met will jump to line 15
sll $zero $zero 0000H #Branch delay if needed, otherwise just a NULL instruction
addu $t1 $s0 $s1
addu $s0 $s1 $zero
addu $s1 $t1 $zero # setting s0 and s1 to next fibonacci numbers
subu $t0 $t0 $s2 #making iteration variable smaller by one
jr $s3 #jump back to the start of loop
sll 0 0 0 
j 0000H #Stop instruction
addu $v0 $s1 $zero #Saving the results in branch delay slot