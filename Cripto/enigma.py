#!/usr/bin/env python
# -*- coding: utf-8 -*- 

cipher = "VUTMBWFXBMISEXIFNPNCJJJLPIWIRNRIBYOIOZMZEISZCWKFRZGQGJSGSLBN"
abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
k1 = 9
k2 = 21
n=len(abc)
L1=[14, 2, 7, 20, 18, 9, 19, 25, 23, 1, 13, 17, 22, 5, 3, 0, 24, 8, 21, 10, 11, 12, 15, 4, 6, 16]
L2=[5, 3, 2, 0, 17, 10, 8, 24, 20, 11, 1, 12, 9, 22, 16, 6, 25, 4, 18, 21, 7, 13, 15, 23, 19, 14]

def LtoS(l):
	s = ''
	for i in l:
		s += abc[i]
	return s	

def q(x,y):
	return (y + x) % n

def lamb(l,x):
	return l.index(x)

def getChar(index):
	m1 = index % 26
	m2 = index / 26
	#step1 = q(m2+k2, abc.index(cipher[index]))
	step1 = q(m2+k2, abc.index(cipher[index]))
	step2 = lamb(L2, step1)
	step3 = q(-m2-k2, step2)
	step4 = q(m1+k1, step3)
	step5 = lamb(L1, step4)
	step6 = q(-m1-k1, step5)
	return abc[step6]

result = ''
for i in range(len(cipher)):
	result += getChar(i)

#print result

#1)SKLIAUTUOTOJE KRAUTUVELEJE SEDI PIRKLYS IR SKAICIUOJASI

cipher = "KTJBCCFNTRTCUEQZWZEDOIXILDFCFPCMGAKQAVKKYCCTMYVDXD"
k1 = 21
L1 = [20, 3, 24, 18, 8, 5, 15, 4, 7, 11, 0, 13, 9, 22, 12, 23, 10, 1, 19, 21, 17, 16, 2, 25, 6, 14]
L2 = [8, 13, 24, 18, 9, 0, 7, 14, 10, 11, 19, 25, 4, 17, 12, 21, 15, 3, 22, 2, 20, 16, 23, 1, 6, 5]

possible = []
for k2 in range(26):
	c = getChar(0)
	if c == "U":
		possible.append(k2)

for k2 in possible:
	result = ''
	for i in range(len(cipher)):
		result += getChar(i)
#	print k2
#	print result

#KEY = 22
#2)UZ NEGYVOMIS IR MIRSTANCIOMIS ZUVIMIS PLACIOMIS MENKEMIS

cipher = "CFVXUBHRNGMDFPZBKRZUETIXOFCTMWZTKRIFECYMFSJXQNUXKDNQRPELCILNOTSVFCNYOYLZSNC"
k1 = 5
k2 = 9
L1 = [8,13,24,18,9,0,7,14,10,11,19,25,4,17,12,21,15,3,22,2,20,16,23,1,6,5]
L2 = [10,2,21,18,23,6,16,14,8,11,1,25,15,20,0,24,17,19,22,5,4,3,9,12,13,7]
s  = [2,4,0,6,1,11,3,8,7,13,16,5,15,9,18,12,10,19,14,17,25,22,21,24,23,20]


def lambpos(l, x):
	return l[x]

def getCharRef(index):
	m1 = index % 26
	m2 = index / 26
	step1 = q(m1+k1, abc.index(cipher[index]))
	step2 = lambpos(L1, step1)
	step3 = q(-m1-k1, step2)
	step4 = q(m2+k2, step3)
	step5 = lambpos(L2, step4)
	step6 = q(-m2-k2, step5)

	ref = s.index(step6)

	step1 = q(m2+k2, ref)
	step2 = lamb(L2, step1)
	step3 = q(-m2-k2, step2)
	step4 = q(m1+k1, step3)
	step5 = lamb(L1, step4)
	step6 = q(-m1-k1, step5)
	return abc[step6]

result = ''
for i in range(len(cipher)):
	result += getCharRef(i)
print result

#3)JIE ZVILGA LYG PINIGELIAI IR PIRKLYS APAKES GODZIAI
