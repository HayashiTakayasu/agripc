
#sample="[["12:00:00","a","b"],["12:00:01","a","b"]]
#  search_same_line_num(sample) # =>2
def search_same_line_num(ary)
  b=ary
  b.map{|i| i.delete_at(0)}# DELETE timeline

  #search max
  c=[]
  max=0
  val=0
  b.each do |d|
    if d!=c
      val=0
      c=d
    else#d==val
       #p "val:#{val}:#{c}:#{d}"
      val+=1
    end
    if max < val
      max=val
      #p "max:#{max}"
    end
  end
  return max
end
if $0==__FILE__
require "csv"

file=ARGV[0] || "./thermo_data.csv.20130203"
ary=CSV.read(file)
max=search_same_line_num(ary)

p max
end
