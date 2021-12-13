addiu t0 zero 0x0001
BEQ t0 zero 0x0003
addiu v0 v0 0x0001
BEQ zero zero 0x0003
addiu v0 v0 0x0001
j 0
sll zero zero zero
BEQ zero zero 0xFFFB
addiu v0 v0 0x0001