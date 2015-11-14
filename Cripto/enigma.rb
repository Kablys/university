@abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
#
# 1 uzduotis
#
@raktas = [0, 21]; @k1, @k2 = @raktas
@rotor1=[5,3,2,0,17,10,8,24,20,11,1,12,9,22,16,6,25,4,18,21,7,13,15,23,19,14]
@rotor2=[20,3,24,18,8,5,15,4,7,11,0,13,9,22,12,23,10,1,19,21,17,16,2,25,6,14]
@sifras = %q(
UKIWK OAFJA KROVF XWGXK MZPRA 
WYIOG IHWAT PQBBL MMJZI SGDCB 
TDXHC HMAHO JVUJB SVGJC ZZFFO 
CERVC HSUIX NSZMJ VZVUQ OIJSX 
DAJIG MUUES KFOTL GUZTY IDMEN 
GEPVU FNUDV KUOXG BXGLF BIQAA 
VNRWD CEREQ LSSNV CSQBD MKMYC 
AJOPR IBCUB KVGBJ MOTNO WEYNL 
MHUCO VSBBJ WGHFT X).gsub(/\s/, '')
def p (x, y)
  (y + x) % @abc.length
end

def λ (rotor, x) #λ^-1
  rotor.index(x)
end
#puts l@rotor1, 5
def decrypt_enigma
  text = '';
  @sifras.each_char.with_index  do |char, index|
    m1 = index % @abc.length
    m2 = index / @abc.length
    k1, k2 = @k1, @k2
    t = @abc[p(-m1-k1, λ(@rotor1, (p m1+k1, p(-m2-k2, λ(@rotor2, p(m2 + k2, (@abc.index(char))))))))]
    text << t
  end
  text
end
puts decrypt_enigma
#
# 2 uzduotis
#
@k1 = 24 
@r1=[5,3,2,0,17,10,8,24,20,11,1,12,9,22,16,6,25,4,18,21,7,13,15,23,19,14]
@r2=[20,3,24,18,8,5,15,4,7,11,0,13,9,22,12,23,10,1,19,21,17,16,2,25,6,14]
@sifras = %q(
OBKFB ERVBJ PGOHG ROTVP WGNXA 
GDCSQ IVEHC LTYUD JOWLW HGCLH 
JJDHJ TXOCW EWQKX BKEQF DMJUO 
QVBPA UIDSV SADGP WLPHK HFJOP 
DNVMO BTKHK CQXZM DQCLR DZTJT 
HKXIM MNGOE DXZIF CZHGL SWCZB 
NAKYD MNWIL EJISK WIKBD OLECQ 
ILLYY RPIDZ EJRCK ZUBMP MTOET 
YPTSS REOAU VZIVP OJTYH TEUHV 
LMVDH KVVCM).gsub(/\s/, '')
def p (x, y)
  (y + x) % @abc.length
end

def λ (rotor, x) #λ^-1
  rotor.index(x)
end
#puts l@rotor1, 5
def decrypt_enigma
  text = '';
  (0..25).each do |k2|
    @sifras.each_char.with_index  do |char, index|
      m1 = index % @abc.length
      m2 = index / @abc.length
      k1, k2 = @k1, k2
      t = @abc[p(-m1-k1, λ(@r1, (p m1+k1, p(-m2-k2, λ(@r2, p(m2 + k2, (@abc.index(char))))))))]
      text << t
    end
    text << "\n\n"
  end
  text
end
puts decrypt_enigma
#
# 3 uzduotis
#
@raktas = [5, 9]; @k1, @k2 = @raktas
@r1=[8,13,24,18,9,0,7,14,10,11,19,25,4,17,12,21,15,3,22,2,20,16,23,1,6,5]
@r2=[10,2,21,18,23,6,16,14,8,11,1,25,15,20,0,24,17,19,22,5,4,3,9,12,13,7]
@reflection=[2,4,0,6,1,11,3,8,7,13,16,5,15,9,18,12,10,19,14,17,25,22,21,24,23,20]
@sifras = %q(
CFVXU BHRNG MDFPZ BKRZU ETIXO 
FCTMW ZTKRI FECYM FSJXQ NUXKD 
NQRPE LCILN OTSVF CNYOY LZSNC 
ZGGQH BWGKY LKBNA ZJGPM TREAE 
MXRWP IADKA UQDQQ IJUHK NTOTL 
IXDOK VUXEF TJQXK TLGTH BOGNM 
QEDLX LTPXX UARSL EKORP YCLMT 
IMYUT OLULX WFKKB SYQYL HPXKY 
WIXJV WBXLC GTVGF EWMEX CBPUC 
RXFFX BWSIP).gsub(/\s/, '')
def l (rotor, x) #λ
  rotor[x]
end
puts l @r1, 1
def decrypt_enigma
  text = '';
  @sifras.each_char.with_index  do |char, index|
    m1 = index % @abc.length
    m2 = index / @abc.length
    x = p(-m2-@k2, l(@r2, (p m2+@k2, p(-m1-@k1, l(@r1, p(m1 + @k1, (@abc.index(char))))))))
    x = @reflection.index(x)
    t = @abc[p(-m2-@k2, λ(@r1, (p m1+@k1, p(-m2-@k2, λ(@r2, p(m2 + @k2, (x)))))))]
    text << t
  end
  text 
end

puts decrypt_enigma
