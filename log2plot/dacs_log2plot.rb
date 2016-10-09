Dir.chdir(File.dirname(__FILE__))
require "csv"
require "time"

require "rubygems"
require "agri-controller"

require "./rb/log_anaryze"
require "./guess_today_dacs_bit"
include AgriController

##
#Dacs log.txt.* to Bit data a day.
#and makes gnuplot(.plot) file
#and execute
files=ARGV[0] || "../log/log.txt.20121204"
_to=ARGV[1] ||"./dacs_log2plot"

Dir.mkdir _to unless File.exist?(_to)  

p list=Dir.glob(files).sort#.delete_if{|dat| dat.include?("~")}
p list.size
hash={}
list.each do |file| 
  day=guess_today(file)
  hash[file]=guess_today(file)
  #p "#{day.strftime("%Y%m%d")}: #{file}"
end

##
#list to plot
list.each do |file|
  ary=[]
  str=File.read(file)
  array=to_array(str)
  data=dacs_bit_to_ary(array)

  today=hash[file]
  tomorrow=today+24*60*60
  p today=today.strftime("%Y-%m-%d")
  p tomorrow=tomorrow.strftime("%Y-%m-%d")
  
  #save _to new file csv txt-file 
  name=File.basename(file) 
  #File.basename(file).split(".txt").each{|str| name+=str}
  p _to
  p filename=_to+"/"+name+".txt"
  
  CSV.open(filename,"w") do |csv|
    data.each do |dat|
      csv << dat
    end
  end
#plot string of this new file
str=  <<"EOS"
#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot
set title "#{today}"
set terminal png size 640,480
set output "#{filename}.png"

set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"     # input

set format x "%H:%M"             # output
set xrange ["#{today} 00:00":"#{tomorrow} 00:00"]
set ytics -5,1,25
set grid xtics ytics
plot "#{filename}" using 1:2 with steps notitle,\
     "#{filename}" using 1:3 with steps notitle,\
     "#{filename}" using 1:4 with steps notitle,\
     "#{filename}" using 1:5 with steps notitle,\
     "#{filename}" using 1:6 with steps notitle,\
     "#{filename}" using 1:7 with steps notitle,\
     "#{filename}" using 1:8 with steps notitle,\
     "#{filename}" using 1:9 with steps notitle,\
     "#{filename}" using 1:10 with steps notitle,\
     "#{filename}" using 1:11 with steps notitle,\
     "#{filename}" using 1:12 with steps notitle,\
     "#{filename}" using 1:13 with steps notitle,\
     "#{filename}" using 1:14 with steps notitle,\
     "#{filename}" using 1:15 with steps notitle,\
     "#{filename}" using 1:16 with steps notitle,\
     "#{filename}" using 1:17 with steps notitle,\
     "#{filename}" using 1:18 with steps notitle,\
     "#{filename}" using 1:19 with steps notitle,\
     "#{filename}" using 1:20 with steps notitle,\
     "#{filename}" using 1:21 with steps notitle,\
     "#{filename}" using 1:22 with steps notitle,\
     "#{filename}" using 1:23 with steps notitle,\
     "#{filename}" using 1:24 with steps notitle,\
     "#{filename}" using 1:25 with steps notitle
EOS
#save plot file     
open("#{filename}.plot","w"){|io| io.print str}
#run gnuplot ! Draw "_to" directory
system("gnuplot #{filename}.plot")
end

