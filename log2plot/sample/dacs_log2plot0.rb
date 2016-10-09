Dir.chdir(File.dirname(__FILE__))
require "csv"
require "time"

require "rubygems"
require "agri-controller"

require "./rb/log_anaryze"
include AgriController
##
#Dacs log.txt.* to Bit data a day.
#and makes gnuplot(.plot) file
#and execute  
  file=ARGV[0] || "./log.txt.20121019"
  ary=[]
  str=File.read(file)
  array=to_array(str)
  data=dacs_bit_to_ary(array)
  if data[0][0]
    today=Time.parse(data[0][0])
    tomorrow=today+24*60*60
    p today=today.strftime("%Y-%m-%d")
    p tomorrow=tomorrow.strftime("%Y-%m-%d")
  else
    today="2013-01-10"
    tomorrow="2013-01-11"
  end
  
  name=""  
  File.basename(file).split(".txt").each{|str| name+=str}
  filename="./dacs_log2plot/"+name+".txt"
  CSV.open(filename,"w") do |csv|
    data.each do |dat|
      csv << dat
    end
  end
str=  <<"EOS"
#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot

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
     
open("#{filename}.plot","w"){|io| io.print str}
system("gnuplot #{filename}.plot")

