addiu t0 zero 0x0001
BNE t0 t0 0x0003
addiu v0 v0 0x0001
BNE t0 zero 0x0003
addiu v0 v0 0x0001
j 0
sll zero zero zero
BNE t0 zero 0xFFFD
addiu v0 v0 0x0001