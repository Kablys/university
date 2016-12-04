@aA,@bA,@cA = [],[],[] 
@a,@b,@c = 0,0,0
@zingsnis = 0
def hb x, y, z, n
  if n > 0 
    hb x, z, y, n-1
    interm = instance_variable_get('@' + x + 'A').pop
    instance_variable_set('@' + z + 'A',instance_variable_get('@' + z + 'A').push(interm))
    puts (@zingsnis += 1).to_s + ". Diską " + n.to_s + " nuo " + x.upcase + " perkelti ant " + z.upcase + '. A=' + @aA.to_s+', B='+@bA.to_s+', C='+@cA.to_s

    #instance_variable_set('@' + x,instance_variable_get('@' + x)-1)
    #instance_variable_set('@' + z,instance_variable_get('@' + z)+1)
    #puts "a:" + @a.to_s + " b:" + @b.to_s + " c:" + @c.to_s

    #test
    
    #puts "\n"
    hb y, x, z, n-1
  end
end

print "Keliu aukstu boksto norite? (nuo 1 iki 10): "
nums = gets
num = nums.to_i
if num >= 1 && num <= 10
  @a = num
  @aA = (1..num).to_a.reverse
  puts 'A=' + @aA.to_s+', B='+@bA.to_s+', C='+@cA.to_s
  hb 'a', 'b', 'c', num
else
  puts "Skaicius turi buti tarp 1 ir 10 imtinai, jusu numeris: " + nums
end
