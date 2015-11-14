# -*- coding: utf-8 -*-
from __future__ import unicode_literals
text = """genhž azsiv jbdjj ntivd asyad 
snmbl sbunv pnvov semao nsngc 
ljžau lžesb zgtke sdodv bnnba 
bitur agibd rgevm """.replace(" ", "").replace("\n","")
print text
def char_to_num(arg):
    switcher = {
            'a' : "11", 'b' : "12", 'c' : "13", u'č' : "14", 'd' : "15",
            'e' : "21", 'f' : "22", 'g' : "23", 'h' : "24", 'i' : "25",
            'y' : "31", 'j' : "32", 'k' : "33", 'l' : "34", 'm' : "35",
            'n' : "41", 'o' : "42", 'p' : "43", 'r' : "44", 's' : "45",
            't' : "51", 'u' : "52", 'v' : "53", 'z' : "54", u'ž' : "55",
            }
    return switcher.get(arg, "00")

firstStr = ""
secondStr = ""
for c in text:
    #print char_to_num(c)[:1],
    #print char_to_num(c)[1:]

    firstStr += char_to_num(c)[:1]

print firstStr

for (op, code) in zip(firstStr[0::2], firstStr[1::2]):
    print op+code
    
