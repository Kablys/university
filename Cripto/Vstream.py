__author__ = 'Vik'

cipher = [94, 131, 189, 8, 22, 137, 115, 236, 69, 212, 186, 197, 252, 200, 36, 62, 98, 98, 168, 74, 22, 91, 135, 185, 1, 30, 140, 125, 247, 67, 197, 177, 200, 230, 214, 39, 51, 119, 100, 170, 80, 9, 77, 131, 188, 20, 24, 134, 123, 245, 68, 199, 187, 197, 234, 207, 51, 53, 102, 101, 160, 74, 24, 77, 152, 185, 21, 30, 144, 117, 236, 80, 207, 165, 223, 235, 197, 44, 55, 119, 106, 178, 88, 11, 91, 131, 181, 19, 4, 135, 97, 244, 80, 216, 181, 200, 230, 202, 34, 56, 98, 125, 174, 86, 15, 65, 129, 172, 7, 4, 139, 96, 252, 91, 212, 165, 222, 250, 215, 39, 41, 117, 100, 172, 88, 11, 71, 135, 185, 21, 22, 139, 97, 245, 88, 212, 185, 197, 253, 214, 42, 56, 102, 120, 168, 93, 30, 90, 136, 178, 7, 2, 144, 119, 237, 95, 220, 163]
key = []
mess = [ord('V'), ord('I')]

def convertToByte(s):
    b = []
    for x in range(8):
        sk = (2**(7-x))
        bi = s // sk
        s -= bi*sk
        b.append(bi)
    return b

def convertToInt(b):
    sk = 0
    for x in range(8):
        s = (2**(7-x))
        sk += b[x]*s
    return sk

def kGen(k, c):
    kNew = []
    for x in range(8):
        p = (c[0]*k[7+x]+c[1]*k[6+x]+c[2]*k[5+x]+c[3]*k[4+x]+c[4]*k[3+x]+c[5]*k[2+x]+c[6]*k[1+x]+c[7]*k[0+x]) % 2
        kNew.append(p)
        k.append(p)
    return convertToInt(kNew)

key.append(mess[0]^cipher[0])
key.append(mess[1]^cipher[1])

c = 1
print(key[1])
for c in range(2**8):
    temp = 0
    if convertToByte(c)[7] == 0:
        continue
    temp = kGen(convertToByte(key[0]), convertToByte(c))
    if temp == key[1]:
        cByte = convertToByte(c)
        print(cByte)
        break

for x in range(2,len(cipher)):
    key.append(kGen(convertToByte(key[x-1]), cByte))
    mess.append(cipher[x]^key[x])

str = []
for x in range(len(mess)):
    str.append(chr(mess[x]))
print("".join(str))
