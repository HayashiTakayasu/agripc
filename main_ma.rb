require "redis"
require "agri-controller"
include AgriController

db=Redis.new
#system("sudo hwclock --hctosys")
begin 
p name=File.read("./user_name.txt").chomp
rescue
 str=`cat /proc/cpuinfo`
p "serialnumber"
p name=str.split(": ").last.chomp
end

before=nil
before2=nil
before3=nil
loop do
  p t=Time.now
  day=t.day
  hour=t.hour
  min=t.min
  #each min do
  if min!=before2
    sleep   10
    before2=min
    `ruby ./thermo_gruff2.rb ./thermo_data/thermo_data2.txt ./thermo_data/thermo_data.jpg`
    sleep 1
    #system("clear")
  end
  
  #each day do
  if hour!=before
    before=hour
    
    #str=`sudo hwclock --hctosys`
    #if str==""
    #  p str=`ruby ./gps/gps_set_time.rb`
    #end 
    
    sleep 5
    `ruby ./thermo_gruff_yesterday.rb`
    `ruby ./thermo_gruff_past.rb`
    `gnuplot ./sample.plot`
    `gnuplot ./co2.plot`
    sleep 1
    #system("clear")
  end
  if day!=before3
    before3=day
    Loger::loger("log/co2.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+",  0")
    Loger::loger("log/fan.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+",  0")
    if db.get("circulator")=="on"
      Loger::loger("log/circulator.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+",0.8")
    else
      Loger::loger("log/circulator.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+",  0") 
    end
    
    step=db.get("window1step")
    if step != ""
      Loger::loger("log/window1_step.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+",  #{step}")
    else
      Loger::loger("log/window1_step.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+",  0")
    end
    begin
      file="bin_ac/htdocs/data/data_#{name}.tar.gz"
       `touch #{file}` unless File.exist?(file)
      if  Time.now.day!= File::stat("bin_ac/htdocs/data/data_#{name}.tar.gz").mtime.day
        p "backup_data"
        `ruby ./backup_data.rb`
      else
        p "data is today"
      end
    rescue =>ex
      p ex
    end
    sleep 5
    begin
      file="bin_ac/htdocs/data/backup_program_#{name}.tar.gz"
      `touch #{file}` unless File.exist?(file)
      if Time.now.day!= File::stat("bin_ac/htdocs/data/backup_#{name}.tar.gz").mtime.day
        p "All backup"
        `ruby ./backup_all.rb`
      else
        p "backup is today"
      end
    rescue =>ex
      p ex
    end
  end
  
  sleep 1800
end

