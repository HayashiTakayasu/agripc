=begin
require "date"

day=Date.today-1
y=day.year.to_s
m=day.month.to_s
d=day.day.to_s
str=""
[y,m,d].each do |s|
  #p s.size
  if s.size==1
    s="0"+s
  end
  str=str+s
end
puts str
=end
ls=Dir.glob("./thermo_data/*a2.csv.*")
ls2=Dir.glob("./thermo_data/*a2.csv.*{jpg,png}")
puts (ls-ls2).sort.last.split(".").last

