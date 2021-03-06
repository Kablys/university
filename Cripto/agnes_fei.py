def Feistelis( m, k ):
    F = (m[1]^^k)&((k//16)|m[1])
    return ( m[1], m[0]^^F )
def Skaitliukas( m, k ):
    F = (m^^k)&((k//16)|m)
    return [F, F] 
def Iteracijos( block, key):
    c = Feistelis( block, key[0] )
    c = Feistelis( c, key[1] )
    c = Feistelis( c, key[2] )
    return [c[1],c[0]]
iv = [0, 44]
key = [44, 154, 41]
tekstas = [[20, 183], [80, 243], [2, 170], [67, 244], [6, 174], [71, 240], [10, 174], [79, 250], [9, 170], [90, 224], [27, 173], [78, 232], [24, 182], [85, 243], [29, 190], [80, 242], [21, 189], [91, 229], [23, 169], [87, 232], [7, 164], [84, 252], [27, 163], [87, 234], [0, 172], [69, 247], [23, 174], [68, 239], [4, 175], [64, 241], [18, 183], [83, 255], [5, 164], [80, 243], [16, 182], [93, 235], [23, 188], [90, 240], [8, 183], [76, 255], [29, 187], [75, 246], [31, 162], [84, 244], [4, 177], [68, 234], [15, 181], [66, 240], [23, 179], [83, 246], [4, 170], [67, 239], [19, 171], [80, 230], [7, 189], [83, 246], [5, 182], [95, 254], [22, 168], [65, 237], [8, 177], [76, 227], [7, 175], [83, 232], [1, 160], [82, 253], [2, 164], [71, 249], [9, 166], [89, 226], [21, 170], [80, 238]]
txt = ''
#antra
for n in tekstas:
    t = Iteracijos(n, key)
    t = [t[0]^^iv[0], t[1]^^iv[1]]
    iv = n
    txt += chr(t[0]) + chr(t[1])
    
txt = ''
i = 0
#ketvirta
for n in tekstas:
    s = Skaitliukas(i, key[0])
    c = Iteracijos(s, key)
    c = [c[0]^^n[0], c[1]^^n[1]]
    i += 1
    txt += chr(c[0]) + chr(c[1])
    
txt = ''
#trecia
for n in tekstas:
    c = Iteracijos(iv, key)
    c = [c[0]^^n[0], c[1]^^n[1]]
    iv = n
    txt += chr(c[0]) + chr(c[1])
txt = ''
