require "csv"
require "time"
module AgriController
  module_function
  
  #string read and separate #=>[[],,,]
  def to_array(str,separater=",")
    ary=[]
    str.each_line do |line|
      ary << line.chomp.split(separater)
    end
    ary
  end
  
  #[]
  def log_anaryze0(one_array)
    res=[]
    n=one_array.size
    if n >= 2
      res[0]=Time.parse(one_array[0])
      res[1]=one_array[1].split(" ")
    end
    if n >=3
      res[2]=one_array[2].split(":")
    end
    res
  end
  
  def log2ary(array)
    ary=[]
    array.each do |one_array|
      ary << log_anaryze0(one_array)
    end
    ary.delete([])
    return ary
  end  
  
  def separate_on_off(ary)
    res=[]
    i=0
    ary.each do |array|
      begin
      if array[1][1].include?("ON")
        unless res[i]
          res << [array[0],array[0],array[1][0]]
        end
      elsif array[1][1].include?("OFF")
        #[on_time,on_time,device]=>[on_time,**off_time**,device]
        res[i][1]=array[0]
        i=i+1
      end
      rescue
      end
    end
    res
  end
  
  ##
  #For ma,mch log
  #  str=File.read(mch_log_file)
  #  log_anaryze(str)
  def log_anaryze(str)
    ary=to_array(str,",")
    res=log2ary(ary)
    str=separate_on_off(res)
  end
  
  #
  #sum([[2012-11-12 10:06:08 +0900, 2012-11-12 10:11:03 +0900, "Fan"],...])
  # =>[["Fan", 6490.0], ["CO2", 6602.0], ["yday", "2012-11-12"]]
  #
  #sum([[2012-11-12 10:06:08 +0900, 2012-11-12 10:11:03 +0900, "Fan"],...],Hash)
  # =>{"Fan"=>6490.0, "CO2"=>6602.0, "day"=>"2012-11-12"}
  def sum(separate_on_off_ary,response=Array)
    if separate_on_off_ary.size>0
    today=separate_on_off_ary[0][0].strftime("%Y-%m-%d")
    else
      return nil
    end
    sum={}
    separate_on_off_ary.each do |ary|
      if sum.has_key?(ary[2])
        #p ary[2]
        sec=ary[1]-ary[0]
        sum[ary[2]]+=sec
      else
        sum[ary[2]]=0
      end
    end
    sum["yday"]=today
    if response==Array 
      res=sum.to_a
    else
      sum
    end
    
  end
  
  def total(list,response=Array)
    hash={}
    list.each do |ary|
      ary.each do |content|
        if hash.has_key?(content[0])
          hash[content[0]]+=content[1]
        else
          hash[content[0]]=content[1]
        end
      end
    end
    if response==Array 
      hash.to_a
    else
      hash
    end
  end
  
  #[[["Fan", 6490.0], ["CO2", 6602.0], ["yday", "2012-11-12"]],...]
  def day_sum(list)
    day_data={}
    sum={}
    hash={}
    list.delete(nil)
    list.each do |ary|
      #DATA 
      p ary
      day=ary.pop# data,day separate.
      
      ary.each do |ar|
        day_data[ar[0]]=ar[1]
        hash[day]=day_data[ar[0]]
        #SUM
        if sum.key?(ar[0])
          sum[ar[0]]+=ar[1]
        else
          sum[ar[0]]=ar[1]
        end
      end
      Dir.chdir(File.dirname(__FILE__))
    end
    [hash,sum]
  end
  ###For Dacs_response datum.
  #
  #str=File.read(dacs_file)
  #ary=to_array(ary)
  #
  #data =>CSV array data(each bit)
  def dacs_bit_to_ary(array)
   ary=array.select{|ar| ar.size>=2 && ar[0]!="Start" }
    
   res=[] 
   ary.each do |ar|
    #p ar 
    x=[]
    
    ar[0].split("").reverse.each do |a|
      x << a.to_f*0.7
    end
    x.each_index do |i|
      x[i]=x[i]+i
    end
    
    res << [Time.parse(ar[1]).strftime("%Y-%m-%d %H:%M:%S"),x].flatten
   end
   res 
  end
  
  #day1 < day2
  def make_gnuplot(drawfile,#="test.png",
    day1,day2,
    plot_command,
    format = 'set format x "%H:%M"',
    ytics = '')#'set ytics "-5,1,25"')
  
str=  <<"EOS"
#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot

set title "#{day1}"
set terminal png size 640,480
set output "#{drawfile}"

set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"     # input

#set format x "%H:%M"             # output
#{format}
set xrange ["#{day1} 00:00":"#{day2} 00:00"]
#{ytics}
set grid xtics ytics
set grid mxtics
set grid mytics
#{plot_command}
EOS
    str
  end
  
    def make_gnuplot_dacs(filename,
    drawfile,#="test.png",
    today,tommorow,
    plot_command,
    format = 'set format x "%H:%M"',
    ytics = '')#'set ytics "-5,1,25"')

  str=  <<"EOS"
#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot
set title "#{today}"
set terminal png size 640,480
set output "#{drawfile}"

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
  str
  end
end
if $0==__FILE__
require "rubygems"
require "agri-controller"
include AgriController

##
#TOTAL CO2 work Hours to hash.
=begin
  file=ARGV[0] || "./log/log.txt.20121111"
  ary=[]
  str=File.read(file)
  ary=to_array(str)
  ary.size
  ary[2]
  x=0
  log_anaryze0(ary[2])
  x=log2ary(ary)
  p x=separate_on_off(x)
  x=log_anaryze(str) 
  kekka=[]
  Dir.glob("./log/*").sort.each do |file|
    p file
    str=File.read(file)
    p ans = log_anaryze(str)
    kekka << ans 
  end
  puts
  puts total(kekka)
=end

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
  require "csv"
  filename="sample_data.txt"
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
set output "test.png"

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
     
open("sample.plot","w"){|io| io.print str} 

##
#CO2 PLOT
  file=ARGV[0] || "./log/log.txt.20121213"
  ary=[]
  str=File.read(file)
  ary=to_array(str,",")#[["Sat Nov 10 06:32:10 +0900 2012", "Fan ON ", "set:20",[]]..]
  def log_anaryze1(one_array)
    res=[]
    n=one_array.size
    if n >= 2
      res[0]=Time.parse(one_array[0])
      res[1]=one_array[1].split(" ")
    end
    res
  end
  p log_anaryze1(ary[2])
  hash={}
  ary.each do |ar|
    res=log_anaryze1(ar)
    res.size
    if res.size>1
      p res[1][0]
      if hash.key?(res[1][0])
        hash[res[1][0]]<<[res[0],res[1][1]]
      else
        hash[res[1][0]]=[[res[0],res[1][1]]]
      end
    end
  end
  #p hash
  #p hash.keys
  p hash["CO2"]
#  p hash["Fan"]
 p hash["heater"]
    today=hash["CO2"][0][0]
    tomorrow=today+24*60*60
    p today=today.strftime("%Y-%m-%d")
    p tomorrow=tomorrow.strftime("%Y-%m-%d")
  
  CSV.open("CO2_#{today}","w") do |csv|
     hash["CO2"].each do |ar|
       #p ar[1]
       if ar[1]=="ON"
        csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),0.7]
       elsif ar[1]=="OFF"
        csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),0]
      end
    end
  end

  CSV.open("Fan","w") do |csv|
    hash["Fan"].each do |ar|
      if ar[1]=="ON"
        csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),1.7]
      elsif ar[1]=="OFF"
        csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),1]
      end
    end
  end
  str=<<"EOS"
plot "CO2_#{today}" using 1:2 with steps,\
     "Fan" using 1:2 with steps
EOS
  a=make_gnuplot("test2.png",today,tomorrow,str)
  file="sample2.plot"
  open(file,"w"){|io| io.print a}
  
end



