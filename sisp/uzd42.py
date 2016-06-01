from random import randrange, choice
from math import ceil
import sys

A = 'ABCDEFGHIJKLMNOPRSTUVZ'
goal = sys.argv[1]

def f(ch):
    return sum(1 for a, b in zip(goal, ch) if a == b)


def cross(p):
    res = []
    for i in range(len(p)//2):
        a = p[2*i]
        b = p[2*i+1]
        split = randrange(len(a))
        res.append(a[:split] + b[split:])
        res.append(b[:split] + a[split:])
    return res

def mutate_gene(ch, i):
    return ''.join(choice(A) if i == j else c for j, c in enumerate(ch))

def mutate(p, pm):
    np = len(p)
    nch = len(p[0])
    n = ceil(np * nch * pm)
    for _ in range(n):
        i = randrange(np)
        j = randrange(nch)
        p[i] = mutate_gene(p[i], j)

NOTFOUND = 2 << 30

def test(M, pm):
    p = [''.join(choice(A) for _ in range(len(goal))) for _ in range(M)]
    for i in range(101):
        ranked = [(f(ch), ch) for ch in p]
        ranked.sort(key=lambda a: -a[0])
        if ranked[0][0] == len(goal):
            return i
        p = cross(tuple(r[1] for r in ranked))
        mutate(p, pm)
    return NOTFOUND

l = []
#for m in range(0):
print("  |  0|.01|.02|.05| .1")
for m in (6, 10, 20, 30):
    li = []
    for pm in (0, 0.01, 0.02, 0.05, 0.1):
        i = 0
        for _ in range(10):
            n = test(len(goal) * m, pm)
            if n != NOTFOUND:
                i += 1
        li.append(i)
    #print(li)
    print("{:2.0f}".format(m)+"|", end="")
    for j in li:
        print("{:3.0f}".format(j), end=" ")
    print()
    l.append(li)


m = 20 * len(goal)
pm = 0

it = 0
success = 0
for _ in range(10):
    n = test(m, pm)
    if n != NOTFOUND:
        it += n
        success += 1
print("Parinkta m:{} p:{}".format(20,pm))
print("Vidutiniskai prireike:{} iteraciju ir is ju rezultata pasieke:{}".format(it / success,success))
#print(it / success, success)

