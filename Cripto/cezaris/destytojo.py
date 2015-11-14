abc=unicode('AĄBCČDEĘĖFGHIĮYJKLMNOPRSŠTUŲŪVZŽ','utf-8')
n=len(abc)
def Ceasar(tekst,k):
    tekstU=tekst.upper()
    t=unicode('','utf-8')
    for r in tekstU:
        if r in abc:
            t+=r
    c=unicode('','utf-8')
    for r in t:
        m=(abc.index(r)+k)%n
        c+=abc[m]
    return c

