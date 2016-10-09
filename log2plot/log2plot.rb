Dir.chdir(File.dirname(__FILE__))

require "./rb/log_anaryze"
include AgriController
s=ARGV[0] || "../log/*txt.*"
_to=ARGV[1] || "./"
Dir.mkdir(_to) unless File.exist?(_to)
#_to=_to+File.read("./name")
  #day1 < day2
  def make_gnuplot2(gnuplot_name,
    drawfile,#="test.png",
    day1,day2,
    plot_command,
    format ='' ,#'set format x "%H:%M"',
    ytics = '')
  
str=  <<"EOS"
#set terminal wxtenhanced
set key left top
#set xlabel
set terminal png size 640,480
set output "#{drawfile}"

set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"


set xdata time
set timefmt "%Y-%m-%d" 
set logscale y 10
#set boxwidth 0.7 absolute

#{format}

set format x "%m/%d"
#set format y "10^(%L)"

#set xrange ["2012-10-01":"2013-1-10"]
#set yrange [10**(-1):10**(3)]
set autoscale
#set ytics -10,1,50
set grid
#{plot_command}
EOS
    str
  end

ls=Dir.glob(s)
p ls
ary=[]
ls.each do |file|
  str=File.read(file)
  ary << sum(log_anaryze(str))
end
ary.delete(nil)#[["CO2", 6405.0], ["Fan", 0], ["yday", "2012-12-10"]]...
#p day_sum(ary)
day_data={}
hash={}
sum={}

    ary.each do |ar1|
      ar1
      
      day=ar1.pop[1]# data,day separate.
      #array=[["CO2", 6405.0], ["Fan", 0]]
      ar1.each do |ar|
        #["CO2", 6405.0]
        day_data[day]=ar
        if hash.key?(ar[0])#"CO2"
          hash[ar[0]]<< [day,ar[1]]
        else#initial
          hash[ar[0]]=[[day,ar[1]]]
        end        
      end
     end 
#{"CO2"=>[["2012-12-10", 6405.0],..] ...}      
#p day_data
hash.keys.each do |key|
  hash[key]=hash[key].sort_by{|val| val[0]}
end
require "csv" 
x=[]
hash.each_key do |key|
  sum=0
  p filename=_to+key
  CSV.open(filename,"w") do|csv|
    hash[key].each do |val|
      dat=val[1]/60/60
      sum+=dat
      csv << [val[0],dat,sum]
    end  
str=<<"EOS"
plot "#{filename}" using 1:2 with lines title "Hour day:#{key}","#{filename}" using 1:3 with lines title "TOTAL:#{key}" 
EOS
plot_file=filename+".plot"
  a=make_gnuplot2(plot_file,filename+".png","t","t2",str)
  File.open(plot_file,"w"){|io| io.print a}
  #go plot!
  #sleep 2
  x << plot_file
  #system("gnuplot #{plot_file}\n")
  #sleep 5   
  end
end
x.each do |plot_file|
  p command="gnuplot #{plot_file}"
  system(command)
end
system("gnuplot TOTAL.plot")

