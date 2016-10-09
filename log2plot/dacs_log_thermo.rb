require "./rb/log_anaryze"
include AgriController
require "csv" 
##
#dacs_log with thermo data
#
# $> ruby dacs_log2plot.rb "../cgi-bin/log/log.txt.*" "./dacs_log2plot"
#
#
#1.regulation Time data"%Y-%m-%d %H:%M:%DS" and save
#2.make plotfile 
#3.chdir and plot
# $> ruby dacs_log_thermo.rb "../cgi-bin/log/thermo/thermo_data.csv.*" "./dacs_log2plot" 
#

#1.regulation Time data and save
s=ARGV[0]
_to=ARGV[1]
Dir.mkdir(_to) unless File.exist?(_to)
pwd=Dir.pwd

list=Dir.glob(s).sort
#list.size

list.each do |file|
  p file
  dir=File.dirname(file)
  basename=File.basename(file)
  
  ary=CSV.read(file)
  
  #delete comments
  
  #p ary.size
  ary.delete_if{|i| i.size==1 or (
    begin;
      Time.parse(i[0])
      false
    rescue
      p i[0]
      true
    end)}
  #p ary.size
  
  ary.map{|x| x[0]=Time.parse(x[0])}
  today=ary[0][0]
  tomorrow=today+24*60*60
  _today=today.strftime("%Y-%m-%d")
  _tomorrow=tomorrow.strftime("%Y-%m-%d")
  
  
  
  save_file=_to+"/"+basename
  p "save_thermo_format: #{save_file}"
  CSV.open(save_file,"w") do |csv|
    ary.each do |dat|
      begin
        #p dat[0]
        #Time Format.
        dat[0]=dat[0].strftime("%Y-%m-%d %H:%M:%S")
        csv << dat
      rescue
        p "raise"
        p dat
        next
      end
    end
  end

#2.make plotfile
  p plot_file=save_file+".plot"
  #plot string of this new file
  filename="log.txt."+today.strftime("%Y%m%d")+".txt"
  basename
  p "log:#{filename}"
  
  if File.exist?(_to+"/"+filename)#log file
  str=  <<"EOS"
#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot
set title "#{today}"
set terminal png size 640,480
set output "#{File.basename(plot_file)}.png"

set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"     # input

set format x "%H:%M"             # output
set xrange ["#{_today} 00:00":"#{_tomorrow} 00:00"]
#set ytics -5,1,25
set grid xtics ytics
plot "#{basename}" using 1:2 with lines title "1:Celsius Degree",\\
     "#{basename}" using 1:($3/3) with lines title "  Humidity(1/3)",\\
     "#{basename}" using 1:4 with lines title "2:Celsius Degree",\\
     "#{filename}" using 1:2 with steps notitle,\\
     "#{filename}" using 1:3 with steps notitle,\\
     "#{filename}" using 1:4 with steps notitle,\\
     "#{filename}" using 1:5 with steps notitle,\\
     "#{filename}" using 1:6 with steps notitle,\\
     "#{filename}" using 1:7 with steps notitle,\\
     "#{filename}" using 1:8 with steps notitle,\\
     "#{filename}" using 1:9 with steps notitle,\\
     "#{filename}" using 1:10 with steps notitle,\\
     "#{filename}" using 1:11 with steps notitle,\\
     "#{filename}" using 1:12 with steps notitle
#     "#{filename}" using 1:13 with steps notitle,\\
#     "#{filename}" using 1:14 with steps notitle,\\
#     "#{filename}" using 1:15 with steps notitle,\\
#     "#{filename}" using 1:16 with steps notitle,\\
#     "#{filename}" using 1:17 with steps notitle,\\
#     "#{filename}" using 1:18 with steps notitle,\\
#     "#{filename}" using 1:19 with steps notitle,\\
#     "#{filename}" using 1:20 with steps notitle,\\
#     "#{filename}" using 1:21 with steps notitle,\\
#     "#{filename}" using 1:22 with steps notitle,\\
#     "#{filename}" using 1:23 with steps notitle,\\
#     "#{filename}" using 1:24 with steps notitle,\\
#     "#{filename}" using 1:25 with steps notitle
EOS
#save plot file     
open(plot_file,"w"){|io| io.print str}



 
#3.chdir and plot
  Dir.chdir(_to)
  p command="gnuplot #{File.basename(plot_file)}"
  system(command)
  Dir.chdir(pwd)
  else
  p "skiped #{filename}"
  end
end

