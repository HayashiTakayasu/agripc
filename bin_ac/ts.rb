#!ruby
# coding:UTF-8
p ARGV.size if $DEBUG
keyword= ARGV[0] || "thermo_data_each_day"
if ARGV.size<1
  dir="./**/*" 
else
  dir=ARGV[1]
end
puts "keyword="+keyword.inspect
puts "dir="+dir.inspect
l=Dir.glob(dir)
l.each do |f|
  begin
    str=File.read(f)
    puts f if str.include?(keyword)
  rescue
    #nothing
  end
end
