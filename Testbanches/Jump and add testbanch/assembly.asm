lw t0 zero 0000
addiu t1 zero 0008
add v0 t1 t0
lw t3 zero 0004
or v0 t3 t0
bltzal v0 0001
addiu v0 zero 0001
addiu v0 zero 0002
addiu v0 zero 0003
add v0 zero ra