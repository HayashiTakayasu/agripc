=begin
before=nil
device=File.read("./config/super4.txt")
system("sudo ./lrelayset -u#{device},15")
loop do
  t=Time.now
  min=t.min
  
  
  if (min/2)!=before
    before=min
    puts Time.now.to_s+",controll loop"
    puts `ruby controller_ma_drb.rb`
  end
  sleep 60
end
=end
require "rubygems"
require "agri-controller"
include AgriController

before=nil
day_before=nil

#set 0 relay
device=File.read("./config/super4.txt")
system("sudo ./lrelayset -u#{device},15")

co2,fan=[2,1]
Loger::loger("log/fan.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+(fan).to_s)

loop do
  t=Time.now
  min=t.min
  day=t.day
  
  if (min/2)!=before
    before=min
    puts Time.now.to_s+",controll loop"
    puts `ruby controller_ma_drb_no_fan.rb`
    #puts `ruby controller_ma_drb.rb`
  end
  if day != day_before
    day=day_before
    Loger::loger("log/fan.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+(fan).to_s)
    Loger::loger("log/co2.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+(co2).to_s)
  end
  sleep 60
end
