addiu t0 zero 0xBFC0
sll t0 t0 0x0004
lw t1 0x0030 t0
lw t2 0x0034 t0
multu t1 t2
mtlo v0
mthi v0
j 0x0