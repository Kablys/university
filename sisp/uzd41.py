import sys

def convert(n):
    s = '{0:04b}'.format(n)
    return tuple(int(i) for i in s)

K = int(sys.argv[1])
po = [2, 3, 7, 9, 10, 14]
Mut = [20, 10, 12, 23, 24, 19, 14, 22, 12, 4, 16, 20, 6, 2, 7, 3, 12, 11, 10, 22]

#Bin masyvas
p = [convert(i) for i in po]

def mutate_gene(ch, i):
    return tuple(g if j != i else 1-g for j, g in enumerate(ch))

from math import ceil

def mutate(p, i):
    m = Mut[i-1]
    ch = ceil(m / 4)
    g = m - 4 * (ch-1)
    p[ch-1] = mutate_gene(p[ch-1], g-1)

def to_int(ch):
    return sum(2**i * g for i, g in enumerate(reversed(ch)))

def cross_two(ch1, ch2):
    return ch1[:2] + ch2[2:], ch2[:2] + ch1[2:]

def cross(p):
    l = [cross_two(p[i], p[j]) for i, j in ((0, 1), (0, 2), (1, 2))]
    res = []
    for i in l:
        res.append(i[0])
        res.append(i[1])
    return res


bestfit = []
sumfit = []
ranked = None
for i in range(1, 21):
    ranked = sorted(tuple((abs(K-to_int(ch)), ch) for ch in p), key=lambda c: c[0])
    bestfit.append(ranked[0][0])
    sumfit.append(sum(r[0] for r in ranked))
    if ranked[0][0] == 0:
        print("Found after {}".format(i-1))
        break
    
    best = ranked[:3]
    p = cross(tuple( ch for _, ch in best))
    mutate(p, i)

print("Iteracija|", end="")
for i in range(20):
    print("{:2.0f}".format(i+1), end=" ")
print("\nBestFit  |", end="")
for i in bestfit:
    print("{:2.0f}".format(i), end=" ")
print("\nSumFit   |", end="")
for i in sumfit:
    print("{:2.0f}".format(i), end=" ")
print()
#print(bestfit)
#print(sumfit)
