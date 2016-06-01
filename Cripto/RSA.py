from fractions import gcd
A='abcdefghijklmnopqrstuvwxyz'
def i_skaiciu(text):
    t=''
    for r in text:
        if r in A:
            ind=A.index(r)+1
            if ind<10: t=t+'0'+str(ind)
            else: t=t+str(ind)
    return int(t,10)  

def i_teksta(M):
    n=M
    text=''
    while n>0:
        ind=n%100
        ind=ind-1
        if (ind>=0) & (ind<len(A)):
            text+=A[ind]
            n=(n-ind+1)//100
        else:
            text+='?'
            n=(n-ind+1)//100            
    return text[::-1]     
    
M=i_skaiciu('vienas')
T=i_teksta(M)
print M,T
n,e,d = [2440179625057388220449822259862837959892833846127500338998283027989268633, 799092205607, 1226660687258538906165137285898822393757954369349356316389207897255283543]
C = 1121584436443494534595345342488570074505009452063407041481853087549304780
M = d/C%n
M = pow(C,d,n)
print i_teksta(M)

Ae = 213928615501
AC = 1420028216320819573358675822298631400666930941924233738805370620790430380

N = e * d - 1
while (N%2 == 0):
    N = N // 2

t = N
# print t
a = 3
a = pow(a,t,n)
while True:
    a_new = pow(a,2,n)
    if a_new == 1:
        break
    else:
        a = a_new
pA = gcd(a - 1,n)
qA = gcd(a + 1,n)
fi_n = (pA - 1) * (qA - 1)
def extended_gcd(aa, bb):
    lastremainder, remainder = abs(aa), abs(bb)
    x, lastx, y, lasty = 0, 1, 1, 0
    while remainder:
        lastremainder, (quotient, remainder) = remainder, divmod(lastremainder, remainder)
        x, lastx = lastx - quotient*x, x
        y, lasty = lasty - quotient*y, y
    return lastremainder, lastx * (-1 if aa < 0 else 1), lasty * (-1 if bb < 0 else 1)
 
def modinv(a, m):
    g, x, y = extended_gcd(a, m)
    if g != 1:
        raise ValueError
    return x % m

d = modinv(Ae, fi_n)
# print "fi_n: " + str(fi_n)
# print "d: " + str(d) #179...
M = pow(AC,d,n)
print i_teksta(M)

#3
AC = 10428333439320370219618203030307457659888424641770777948454359392871801
m1 = pow(AC, (pA+1)/4, pA)
m2 = pow(AC, (qA+1)/4, qA)
a = modinv(qA,pA)
b = modinv(pA,qA)

print i_teksta((m1 * a * qA + m2 * b * pA)%n)
print i_teksta((m1 * a * qA - m2 * b * pA)%n)
print i_teksta((-m1 * a * qA + m2 * b * pA)%n)
print i_teksta((-m1 * a * qA - m2 * b * pA)%n)
