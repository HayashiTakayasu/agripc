#p "0"
require "rubygems"
require "time"
require "agri-controller"
require "./counter"
include AgriController
require "drb"
require "timeout"
co2,fan=[2,1]
$diff=0
$ts=DRbObject.new_with_uri('druby://localhost:12345')
#read manual flag
$co2_allow_step=nil
manual=yaml_dbr("manual_0-0.txt","config/manual_0-0.txt")

if manual[-1]=="1" or manual[-2]=="1"#CO2,Fan manual_flag
  #manual flag load
  manual_flag=yaml_dbr("manual_0-1.txt","config/manual_0-1.txt")
  
else
  co2_manual=nil
  fan_manual=nil    
end

if manual[-1]=="1"
  if manual_flag[-1]=="1"
    co2_manual=true
  else
    co2_manual=false
  end
end
if manual[-2]=="1"
  if manual_flag[-2]=="1"
    fan_manual=true
  else
    fan_manual=false
  end
end
#logger (moved controll_loop.rb (day_change))
#Loger::loger("log/fan.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+fan.to_s)
#Loger::loger("log/co2.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+co2.to_s)
def et360(string,set)
  super4_SerialNumber=File.read("config/super4.txt")
  tuple="super4"  
  begin
    
    $ts.write([tuple,[set,string]])
    #AgriController::ET360::send(string,set)
    #`sudo ./lrelayset -#{set}#{super4_SerialNumber},#{string}`
  rescue
    #p "et360 error."
    p "relay error"
  end
end

#AgriController::ET360::reset("192.168.0.100")
#et360("00","192.168.0.100")
#`sudo ./lrelayset -uFTVN77AC,15`
#initialize
if co2_manual==true
  if fan_manual==true
    et360("3","s")
    #et360("12","u")
  else
    et360("1","s") 
    et360("2","u")
  end
elsif fan_manual==true
  et360("2","s")
  et360("1","u")
else
  et360("3","u") 
end

#define controll values
begin
  load "./config/config.txt"
rescue SyntaxError
  p "./config/config.txt SyntaxError"
  $work_time=["6:00","16:00"]
  $fan_sec =100
  $burn_sec =360
  $dead_sec =50

  $co2_config=[["7:00",800],["11:00",400],["16:00",0]]
  $temp_config=[["7:00",27],["15:00",30]]
  $heater_config=[["7:00",0]]
end
work_time=$work_time
fan_sec  =$fan_sec
burn_sec =$burn_sec
dead_sec =$dead_sec

co2_config=$co2_config
temp_config=$temp_config
heater_config=$heater_config

#ppm=N_dan_thermo.new([["7:00",1500],["11:00",1200],["15:00",0]])
ppm=N_dan_thermo.new(co2_config)


#temp=N_dan_thermo.new([["7:00",27],["11:00",25],["15:00",27]])
temp=N_dan_thermo.new(temp_config)

heater_temp=N_dan_thermo.new(heater_config).set_now
#ppm.list.inspect
start_ppm=ppm.set_now
  now_ppm=nil

high_temp=temp.set_now
  now_temp=nil


  last_time=nil

#in
begin
  str=File.read("last_data").chomp.split(",")
  last_time = Time.parse(str[0])
  now_temp  = str[1].to_f
  now_humidty=str[2].to_f#no need 
  now_ppm   = str[3].to_f
  
rescue
  str=nil
end


#out

=begin
"str" works
last_time+300 > Time.now #value untrusted. skip 

 *timer true
  * ppm Low(start_ppm >= now )
  * Ventiration Fan on,if High Temperature before CO2 generation.
  * CO2 generation
  *sleep 300 #next judge 
=end

p [co2_manual,fan_manual,start_ppm,high_temp]
Loger::loger("./log/log.txt","#{Time.now},start") if $DEBUG
    if str!=nil && (last_time+60 > Time.now)
      timer(work_time[0],work_time[1]) do |bool| 
        if bool#time
            i=0
            fan_bool=nil
            while high_temp < now_temp#high_temp before Burn.
              i=i+1
              break if (fan_manual!=nil) or (i>10)
              if i==1
              str1="#{Time.now.to_s},Fan ON ,set:#{high_temp.to_s},#{str.inspect}"
              p "fan start"
              p str1;Loger::loger("log/log.txt",str1)
              #et360("02","192.168.0.100")#Fan on
               et360("2","s")#Fan on 
               Loger::loger("log/fan.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+(fan+0.8).to_s)
               #$ts.write(["et360",[[true,1],"192.168.0.100"]])              
              end
              
              sleep fan_sec
              counter("./log/fan_min.txt",fan_sec/60.0)
              
              fan_bool=true
              #fan off?
              begin
                str=File.read("last_data").chomp.split(",")
                last_time = Time.parse(str[0])
                now_temp  = str[1].to_f
                now_humidty=str[2].to_f#no need 
                now_ppm   = str[3].to_f
                
              rescue
                str=nil
              end
              
            end
            p [fan_bool,i]
            if i>0 #fan_bool==true
              #et360("00","192.168.0.100")#Fan off
               et360("2","u")#Fan off
               Loger::loger("log/fan.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+fan.to_s)
              str1="#{Time.now.to_s},Fan OFF"
              p str1;Loger::loger("log/log.txt",str1)
            end
              sleep 5
          
          ##CO2 stage
          allow=nil
          must=nil
          step=nil
          if start_ppm >= now_ppm && co2_manual==nil #ppm low?
            begin
              timeout(1) do
                step=$ts.read(["window1step",nil])[1]#rain:"1",step:Fixnum,nil
              end
            rescue Timeout::Error
              step=nil
            rescue
              step=nil
            end
            #$co2_allow_step
            if $co2_allow_step==nil
              allow=true
            else #$co2_allow_step.class==Fixnum
              if step==nil #initialize
                allow=true
              elsif step=="1"#rainy
                allow=true
              elsif step=="manual"
                allow=true
              else
                #allow=true
                if $co2_allow_step >= step
                  p step
                  must=true
                end
              end
            end
            b=[$co2_allow_step,step,allow,must,"$co2_allow_step,step,allow,must"]
            if (i<=1 && allow ) || must #not high temp or allowed
              str1="#{Time.now.to_s},CO2 ON ,set:#{start_ppm.to_s},#{str.inspect}#{b.inspect}"
              p str1;Loger::loger("log/log.txt",str1)
              
              #et360("01","192.168.0.100")#CO2 on
              et360("1","s")#CO2 on
             #et360("8","s")#CO2 on
              Loger::loger("log/co2.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+(co2+0.8).to_s)
              sleep burn_sec
              counter("./log/co2_min.txt",burn_sec/60.0)
              #et360("00","192.168.0.100")#CO2 off
              et360("1","u")#CO2 off
              Loger::loger("log/co2.txt",Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+co2.to_s)
             #et360("8","u")#CO2 off
              str1="#{Time.now.to_s},CO2 OFF"
              p str1;Loger::loger("log/log.txt",str1)

            else
              str1="#{Time.now.to_s},temp High. CO2 canceled."
              p str1;Loger::loger("log/log.txt",str1)
            
            end
            sleep dead_sec
            
            str1="#{Time.now.to_s},action end"
            p str1;Loger::loger("log/log.txt",str1)
          end
          
        end
      end      
    end
            i=0
            heater_bool=false
            if (heater_temp > now_temp) && false  #cold and cancel
              i=i+1
              str1="#{Time.now.to_s},CO2 ON ,heater:#{heater_temp.to_s},#{str.inspect}"
              
              p str1;Loger::loger("log/log.txt",str1)
              #et360("02","192.168.0.100")#Fan on
              
              #et360("1","s")#CO2 on
              #et360("8","s")#CO2 on 
               #$ts.write(["et360",[[true,1],"192.168.0.100"]])              
              sleep 600
              heater_bool=true
              #fan off?
              
              #begin
              #  str=File.read("last_data").chomp.split(",")
              #  last_time = Time.parse(str[0])
              #  now_temp  = str[1].to_f
              #  now_humidty=str[2].to_f#no need 
              #  now_ppm   = str[3].to_f
              #  break if now_ppm > 3000 
              #rescue
              #  str=nil
              #  break
              #end
            end
            
            if heater_bool
              #et360("00","192.168.0.100")#Fan off
              
              #et360("1","u")#CO2 off
              #et360("8","u")#CO2 off
              str1="#{Time.now.to_s},CO2 OFF"
              p str1;Loger::loger("log/log.txt",str1)
              heater_bool=false
            end

