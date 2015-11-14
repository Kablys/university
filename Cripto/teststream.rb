@k= [1, 0, 1, 1, 0, 1, 0, 1] #raktas 
@sifras = [152, 58, 221, 87, 65, 24, 198, 254, 251, 68, 224, 176, 139, 192, 167, 55, 120, 245, 5, 35, 128, 136, 107, 30, 106, 73, 170, 121, 164, 214, 23, 154, 40, 216, 70, 92, 14, 214, 225, 225, 88, 225, 162, 156, 205, 176, 59, 118, 240, 11, 37, 150, 136, 111, 25, 100, 80, 177, 111, 169, 201, 25, 148, 50, 209, 84, 65, 24, 206, 225, 225, 86, 230, 166, 138, 198, 191, 34, 116, 240, 21, 60, 135, 157, 96, 4]
def num_to_binarr num
  arr = []
  num.to_s(2).each_char {|c| arr << c.to_i}
  arr = [0]*(8 - arr.length) + arr
  arr
end
@srautas = []
@sifras.each do |c|
  @srautas.concat(num_to_binarr(c))
end

@poros = @srautas.each_slice(2).to_a
@p_num = [0, 0, 0, 0]
#print @poros
@poros.each do |p|
  
  case p
  when [0, 0]
    @p_num[0] += 1
  when [0, 1]
    @p_num[1] += 1
  when [1, 0]
    @p_num[2] += 1
  when [1, 1]
    @p_num[3] += 1
  else
    puts 'what?'
  end

end

def bit_pair_test(srautas)
  l = srautas.length
  x = (4.0/(l-1)) * (@p_num[0]**2 + @p_num[1]**2 + @p_num[2]**2 + @p_num[3]**2) 
  y = (2.0/l) * ((@srautas.select{ |n| n == 0}.length ** 2) + (@srautas.select{ |n| n == 1}.length ** 2))
  x - y + 1
end

def single_bit_test(srautas)
  l = srautas.length
  ((@srautas.select{ |n| n == 0}.length) - (@srautas.select{ |n| n == 1}.length))**2 / l.to_f
end
def autocorelation_test(srautas)
  n = srautas.length
  d = n / 2 - 1
  #puts d
  suma = 0
  (n - d + 1).times do |i|
    suma += (srautas[i] ^ srautas[i+d-1])
  end
  (2 * suma - n + d) / (Math.sqrt(n - d))
end
   puts bit_pair_test @srautas
   puts single_bit_test @srautas
   puts autocorelation_test @srautas
exit

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
