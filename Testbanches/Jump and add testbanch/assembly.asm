lw zero t0 0000
addiu zero t1 0008
add t0 t1 v0
lw zero t3 0004
or t0 t3 v0
bltzal v0 0001
addiu zero v0 0001
addiu zero v0 0002
addiu zero v0 0003
add ra zero v0