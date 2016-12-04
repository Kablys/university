@A = ['A','B','C']
def move(ns, x=0, y=1, z=2)
  if ns == 1
   @towers[y] << @towers[x].pop
  else
    move(ns-1, x, z, y)
    puts "Diska #{ns} nuo #{@A[x]} perkelti ant #{@A[z]} : #{@towers}"
    move(ns-1, y, x, z)
  end 
end
 
n = 3
@towers = [[*1..n].reverse, [], []]
move(n)
