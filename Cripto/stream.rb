@k1= ['V', 'I'] #raktas 
@sifras=[94,131,189,8,22,137,115,236,69,212,186,197,252,200,36,62,98,98,168,74,22,91,135,185,1,30,140,125,247,67,197,177,200,230,214,39,51,119,100,170,80,9,77,131,188,20,24,134,123,245,68,199,187,197,234,207,51,53,102,101,160,74,24,77,152,185,21,30,144,117,236,80,207,165,223,235,197,44,55,119,106,178,88,11,91,131,181,19,4,135,97,244,80,216,181,200,230,202,34,56,98,125,174,86,15,65,129,172,7,4,139,96,252,91,212,165,222,250,215,39,41,117,100,172,88,11,71,135,185,21,22,139,97,245,88,212,185,197,253,214,42,56,102,120,168,93,30,90,136,178,7,2,144,119,237,95,220,163]
def num_to_binarr num
  arr = []
  num.to_s(2).each_char {|c| arr << c.to_i}
  arr = [0]*(8 - arr.length) + arr
  arr
end

@t1 = num_to_binarr(@sifras[0] ^ @k1[0].ord)
@t2 = num_to_binarr(@sifras[1] ^ @k1[1].ord)
@t = @t1 + @t2
# lookup_table = Hash.new { |h, i| h[i] = i.to_s(2) }
@keys = []
(2**8).times do |c|
  next unless (c | 0b11111110) == 0b11111111 
  num_to_binarr(c)
  @sum_arr = []
  @sum = 0
  (0..7).each do |i|
    (0..7).each do |j|
      @sum += c[j]*@t[i + (7 - j)]
    end
    @sum_arr << (@sum % 2)
  end
  @keys << c if @sum_arr == @t2
end
@keys.each do |s|
puts s.to_s(2)

end

@bin_sifras = []
@sifras.each do |i|
  @bin_sifras += num_to_binarr(i)
end
#print @bin_sifras
@keys.clear
@keys << 0b01111101
@sum_arr.clear
@keys.each do |c|
  #puts c
  cif = num_to_binarr(c)
  (7..@bin_sifras.length - 8).each_with_index do |i,index|
    (0..7).each do |j|
      @sum += cif[j]*@bin_sifras[i + (7 - j)]
    end
    @sum_arr << (@sum % 2)
    if index % 8 == 7 
      print @sum_arr.to_s.gsub(/[\[\], ]/, '').to_i(2).chr + ' '
      @sum_arr.clear
    end  
  end
  @sum_arr.clear
 # print "\n\n\n\n\n"
end
#01111101
#puts @sifras.length
# puts @t1.to_s.gsub(/[\[\], ]/, '')#.to_i(2)#.chr + ' '
# print @t1
# puts @t2.to_s.gsub(/[\[\], ]/, '').to_i(2)#.chr + ' '
# print @bin_sifras
#print @keys

# 255.times do |i|
#   @sifras.each do |x|
#     l0 = x.first
#     r0 = x.last
#     l1 = r0
#     r1 = l0^func(r0,@k1) 
#     l2 = r1
#     r2 = l1^func(r1,i) 
#     l3 = r2
#     r3 = l2
#     if ((65..90) === l3 && (65..90) === r3) 
#       print l3.chr, r3.chr
#     else
#       break
#     end
#   end
#   #puts ''
# end
