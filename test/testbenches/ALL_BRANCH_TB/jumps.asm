addiu s1 zero 0x0001 // s1 = 1
addiu t0 zero 0x0003 // t0 = 3
addiu t1 zero 0x0002 // t1 = 2
BEQ t0 t1 0x05D
addiu v0 zero 0x0001 //BEQ fails on not equal v0 = 1
addu t1 t1 s1 //t1 = 3
BEQ t0 t1 0x0003
addiu v0 v0 0x0001 // BEQ fails on equal v0 = 2
J 0
subu t1 t1 s1 // t1 = 2
BGEZ zero 0x002
addiu v0 v0 0x0001 // BGEZ fails on zero v0=3
J 0
BGEZ t0 0x002
addiu v0 v0 0x0001 // BGEZ fails on v0>0 v0=4
J 0
subu t2 zero t0 // t2 =
BGEZ t2 0x0042
addiu v0 v0 0x0001 // BGEZ fails on v0<0 v0=5
BGEZAL t0 0x0040
addiu v0 v0 0x0001  // BGEZAL fails on link v0 = 6
J 0
BGEZAL zero 0x002
addiu v0 v0 0x0001 // BGEZAL fails on zero v0=7
J 0
BGEZAL t0 0x002
addiu v0 v0 0x0001 // BGEZAL fails on v0>0 v0=8
J 0
subu t2 zero t0
BGEZAL t2 0x036
addiu v0 v0 0x0001 // BGEZAL fails on v0<0 v0=9
BGTZ zero 0x034
addiu v0 v0 0x0001 // BGTZ fails on v0=0 v0=10
BGTZ t2 0x032
addiu v0 v0 0x0001 // BGTZ fails on v0<0 v0=11
BGTZ t1 0x0002
addiu v0 v0 0x0001 // BGTZ fails on v0>0 v0=12
J 0
BLEZ zero 0x0002
addiu v0 v0 0x0001 // BLEZ fails on v0=0 v0=13
j 0
BLEZ t2 0x0002 
addiu v0 v0 0x0001 // BLEZ fails on v0<0 v0=14
j 0
BLEZ t1 0x0027
addiu v0 v0 0x0001 // BLEZ fails on v0>0 v0=15
BLTZ t1 0x0025
addiu v0 v0 0x0001 // BLTZ fails on v0>0 v0=16
BLTZ zero 0x0023
addiu v0 v0 0x0001 // BLTZ fails on v0>0 v0=17
BLTZ t2 0x0002
addiu v0 v0 0x0001 // BLTZ fails on v0>0 v0=18
j 0
BLTZAL t2 0x001F
addiu v0 v0 0x0001 // BLTZAL fails on link v0>0 v0=19
BLTZAL t1 0x001C
addiu v0 v0 0x0001 // BLTZAL fails on v0>0 v0=20
BLTZAL t1 0x001A
addiu v0 v0 0x0001 // BLTZAL fails on v0>0 v0=21
BLTZAL zero 0x0018
addiu v0 v0 0x0001 // BLTZAL fails on v0=0 v0=22
BLTZAL t2 0x0002
addiu v0 v0 0x0001 // BLTZAL fails on v0<0 v0=23
j 0
BNE zero zero 0x0013 
addiu v0 v0 0x0001 // BNE fails on 0=0 v0=24
BNE t1 t2 0x0002 
addiu v0 v0 0x0001 // BNE fails on t0!=t1 v0=25
j 0
addiu s3 zero 0xBFC0
sll s3 s3 0x0010
addiu s3 s3 0x012C
addiu v0 v0 0x0001 // JR fails v0=26
JR s3
j 0
addiu s5 s3 0x0000
addiu s3 s3 0x01C
addiu s5 s5 0x0008
JALR s3 s4
BEQ s5 s4 0x002
addiu v0 v0 0x0001 // JALR fails v0=27
j 0
addu v0 v0 0x0001
JAL 0
j 0 // Exit address
sll zero zero 0x0000
addiu t5 ra 0x0004 // Return test
JR t5
j 0