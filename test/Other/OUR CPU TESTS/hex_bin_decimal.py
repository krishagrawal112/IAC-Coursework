a = 14
for i in range(1, 16):
    if i < 8:
        a += 8*(16**i)
    else:
        a += 15*(16**i)

b = 4
for i in range(1, 8):
    b += 4*(16**i)

print(hex(a//b))
print(hex(a%b))

print(hex(73*4))    