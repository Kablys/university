# -*- coding: utf-8 -*-
from __future__ import unicode_literals
def railFenceDec(cipher, key):
    cipher = cipher.replace(" ", "")
    print cipher
    if key == 1:
        return cipher
    result = "" 
    i = 1
    while i < len(cipher):
        if (i % (2*(key-1))) == 1:
            print i
            result += cipher[i-1]
        i += 1
    return result
print railFenceDec("AITDU OKIOE OOTKA LSUOO RNNNA VRUNE JKKSU RIPOE GIKKŲ RSAĖS EŽALI ŽSEŠB IPMTT RVDGE EOUIA REIAS LVUII LIVMN NTŪŠT E", 4)
