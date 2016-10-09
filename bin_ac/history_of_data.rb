#!ruby -Ku
#coding:utf-8
require "date"
require "rubygems"
require "agri-controller"
module AgriController
module_function
  #history of watering.
  #history_of_watering(history=5,water_line=[1,2,3],file="log.txt") 
  #        # => [[10,20,10,20,20],[...],[...]] #each lines watering seconds Array.
  def history_of_watering(history=nil,water_line=[1,2,3],file="log.txt")
    #p history.class
    time_list=[]
    time_each_line=[]
    
    res=[]
    start_flag=false
    ##
    #data_config
    #time_list
    a=File.read(file)
    a.each_line do |line|
      line=line.chomp
      #win(kr)_log
      if line.include?("KR01:")
        #p line
        data=line.split(",")
        time_list<< [data[0],data[1]]
      end
      
      #linux_log
      str0=line.slice(0,1)
      if str0=="0" or str0=="1"
        #p line
        #"000000000000101000010001,2010-11-10T16:14:14+09:00,15.5,72,15.7,22.5,step:4,step:4,[24, 24]\n"
        data=line.split(",")
        time_list<< [data[0],data[1]]
      end
    end
    #p time_list
    #[["000000000000000000000011", "2010-11-10T16:00:00+09:00"], ["000000000000000000000000", "2010-11-10T16:03:00+09:00"], ["000000000000000000000101", "2010-11-10T16:04:00+09:00"], ["000000000000000000000000", "2010-11-10T16:07:00+09:00"], ["000000000000000000001001", "2010-11-10T16:08:00+09:00"], ["000000000000000000000000", "2010-11-10T16:11:01+09:00"]]
    #[["KR01:1010", "Sun Nov 07 12:00:00 +0900 2010"], ["KR01:0000", "Sun Nov 07 12:04:00 +0900 2010"], ["KR01:1101", "Sun Nov 07 12:04:30 +0900 2010"], ["KR01:0000", "Sun Nov 07 12:07:30 +0900 2010"], ["KR01:1010", "Sun Nov 07 14:00:00 +0900 2010"], ["KR01:0000", "Sun Nov 07 14:04:00 +0900 2010"], ["KR01:1101", "Sun Nov 07 14:04:30 +0900 2010"], ["KR01:0000", "Sun Nov 07 14:07:30 +0900 2010"]]
    
    ##
    #Parse time_list,each waterline Bit
    water_line.each do |i|
      dat=[]
      start_end=[t=Time.now,t]
      time_list.each do |data|
        if start_flag==false && data[0].slice(-1-i,1)=="1"
            start_end[0] = data[1]
            start_flag=true
            "start:"+data.inspect
        end
        if start_flag==true && data[0].slice(-1-i,1)=="0"
            start_end[1]= data[1]
            dat << start_end
            start_end=[t=Time.now,t]
            start_flag=false
            "end:"+data.inspect
        end
        
      end
      res << dat
    end
    
  #print res.to_s
  #res.each{|s| p s.size}
  
  ##
  #last result
  result=[]
  res.each do |list|
    x=[]
    list.each do |i|
      t1=i[0]
      t2=i[1]
      #day to seconds
      #t1.inspect+","+t2.inspect
      begin
      x  << (DateTime.parse(t2)-DateTime.parse(t1))*86400.to_f
      rescue
        x << -1
      end
    end
    #p x
    unless history.class!=Fixnum
      if x.size > history
        result << x.slice(-history..-1)
      else
        result << x
      end
    #all_list
    else
      result << x
    end
  end
    result
  end
  
  def to_table(array)
    res=""
    line1="<td> </td>"
    num = 0
    #define first line
    array.each do |ar|
      x=ar.size
      line1 = line1 + "<td>#{(x-num).to_s}</td>"
      num =num +1
      res=res+"<td>#{num.to_s}</td>"
      ar.each do |dat|
        res=res+"<td>#{dat.to_s}</td>"
      end
      res =res +"<tr/>\n"
    end
    res
  end
end
if $0==__FILE__
loop do#require "pp"
begin
t=Time.now
p r1=AgriController::history_of_watering(nil,water_line=[1,2,3],file="./cgi-bin/log/log.txt")

#r2=AgriController::history_of_watering(history=nil,water_line=[1,2],file="_log.txt")
table=AgriController::to_table(r1)
#AgriController::to_table(r2)
open("./htdocs/table.htm","w") do |io| 
io.print <<EOS 
    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <META HTTP-EQUIV="Refresh" CONTENT="60;URL=./table.htm">

          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>table.htm</title>
      </head>
EOS

  io.print "<table border='1'>\n"+table+"</table>\n<img src='watering.png' alt='watering.png' />"
  io.print "</html>"
end
require 'rubygems'
require 'gruff'

g = Gruff::Line.new(view="500x300")
g.title = "Watering time chart" 
g.theme_37signals
#g.maximum_value = 120
#g.minimum_value = 0
#g.y_axis_increment = 20
#g.baseline_value=120
g.data("line1", r1[0])
g.data("line2", r1[1])
g.data("line3", r1[2])
#g.data("line4", r1[3])

#g.data("line4", [9, 9, 10, 8, 7, 9])

g.labels = {0 => 'time_line', r1[0].size-1 => 'last -->'}

g.write('./htdocs/watering.png')

p Time.now-t
rescue => ex
  #Error handling
  x0=ex.class.to_s
  x1=ex.message
  x2=ex.backtrace.to_s
  
  p x="error :"+Time.now.to_s+","+x0+x1+x2
  AgriController::Loger::loger("history_error.txt",x+"<br/>")
end
sleep 600
end

end
