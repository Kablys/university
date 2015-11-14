@abc = 'AĄBCČDEĘĖFGHIĮYJKLMNOPRSŠTUŲŪVZŽ'
@raktas = 'KELIAS'
@sifras = %q(
RASRU LIAĮŽ YĘCLŽ ZHCĮO GŪAKŠ 
PNGEJ ĮĖBZG SBPČG ĮVROG ZKTFT 
NVAĮL DĘTYĘ FŲČGO ĘFADD JVNMN 
RĮMRA FŠNLJ JŽIRK ŠPNĄN HUIIZ 
GCVPN CJSOT ĘĘEĘV IĖŪRY ŠSNČH 
ŽOSŽĄ NVJOG ŽHSKE IDYĮŽ IIZLT 
SVĘŽU ĘVRIZ NCBAP GKEVU GČŽCB 
ŽŽGOY FUIRG YYUDČ LKCBŲ TEFVI 
ŽAUIO KNRZC VVŽŪU CĮUFR AIVTK 
RKKFN ĘCEĘR AŽUUY ŽUKZT CKODG 
GSBSĘ ŲESNI ĘZKTF TNVAI VSIZS 
C
).gsub(/\s/, '')

def decrypt_vigenere
  zinute = "" 
  @sifras.each_char.with_index do |c, index|
    k = @raktas[index % @raktas.length]
    m = (@abc.index(c) - @abc.index(k)) % @abc.length
    zinute << @abc[m]
  end
  return zinute
end

print decrypt_vigenere.to_s
