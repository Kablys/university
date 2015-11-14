@public_key= [180538, 84027, 152587, 55350, 15908, 106528, 107048, 197634]
@sifras = [399012, 596126, 663732, 596646, 557204, 152587, 399012, 663732, 647824, 540776, 596646, 152587, 505540, 434248, 596646, 434248, 399012, 434248]
@first = 1173 #first_private_key_component 
@modulis = 203423
def num_to_binarr num
  arr = []
  num.to_s(2).each_char {|c| arr << c.to_i}
  arr = [0]*(8 - arr.length) + arr
  arr
end

#DBD(s,p) = 1 s?
galimos_s = (1..@modulis).select { |s|  s.gcd(@modulis) == 1}
galimos_s.select! { |s| (@public_key[0] * s) % @modulis == @first  }
@s = galimos_s[0]
@private_key = @public_key.map {|public| (public * @s) % @modulis}
@talpa = @sifras.map { |c| (c * @s) % @modulis}
puts @s
print 'Talpa ' + @talpa.to_s + "\n"
print 'Svoris' + @private_key.to_s + "\n"
print 'Verte ' + @public_key.to_s + "\n"

def value(bin, talpa)
  value = 0
  bin.each.with_index do |bit, index|
    if (bit == 1)
      talpa = talpa - @private_key[index]
      return -1 if talpa < 0
      value += @public_key[index]
    end
  end
  return value
end

def find_values(talpa)
  @posible = (0..255).map{|x| num_to_binarr(x)}.max_by do |num|
    value(num, talpa)
  end
  print @posible.to_s.gsub(/[\[\], ]/, '').to_i(2).to_s + ' '
end


@talpa.each { |talpa| find_values talpa}


exit

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
