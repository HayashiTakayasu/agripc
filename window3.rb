require "redis"
require "agri-controller"
require "./setting_io"
load "./value_controller.rb"
include AgriController
##old
#use drb tuple space
#require "drb"
#$ts=DRbObject.new_with_uri('druby://localhost:12345')
db=Redis.new

tuple_name="window3"
open_bit="6"
close_bit="7"
dif=6
p $temp_config=yaml_dbr(tuple_name,"./bin_ac/cgi-bin/config/#{tuple_name}")

#define controll values
temp_config=$temp_config

#ts[tuple_name,[true,false]]

min_before=nil
min_before2=nil
hour_before=nil
day_before=nil
change=[nil,nil,nil]
rain=db.get(:rain)

#p "#{tuple_name}_start"
sleep 2

catch :reset_signal do
  house1=N_dan_thermo.new(temp_config)#read data
  window=Value_controller.new(steps=6,open_sec=20,#55
    down_sec=18,#35,
    sensitivity=0.5,set=17,dead=30,true,false)
  p window
  #default_value
  temp=0#error
  loop do
    t=Time.now
    
    if min_before!=t.min && t.sec%10<8
       min_before=t.min
      sleep 0.2
      try=0
      begin
        #data=thermo_read("http://127.0.0.1:8000/last_data")
        #data=File.read("./last_data").chomp
        data=db.get("degree")
        temp=data.to_f
        #if data.class==String
        #temp=data.split(",")[1].to_f
        
        #else
          #none
          #p temp=15.0+rand(20)
        #end
      rescue
        try+=1
         p "error occured. prease reboot!"
         p data
        sleep 1
        retry if try <=3
      end
#define controll values
p tuple_name+" , [open,close]="+open_bit+","+close_bit
p $temp_config=yaml_dbr(tuple_name,"./bin_ac/cgi-bin/config/"+tuple_name)

#define controll values
temp_config=$temp_config

    end
    house1=N_dan_thermo.new(temp_config)
    window.set_value=house1.set_now
    if temp
      hot         =window.value_controll(temp)#true or false
      switch      =window.switch
      open_signal= (hot && switch)
      close_signal=((!hot) && switch)
      #close_signal=false  if (close_signal and open_signal)==true
    end
   
    #tel steps
    
    #rain_sensor work
      #rain=`cat ./rain.txt`.chomp #"1","0"  ,""(error?)
      rain="0" #if no need rain sensor work
      
#      while rain==""
#        sleep 1
#        p "retry rain.txt"
#        rain=`cat ./rain.txt`.chomp 
#      end
#      #rain=`sudo python ./run_rain_sensor.py`.chomp
      if rain =="1"
        #p "rain_sensor woks"
        window.now_step=0        
        open_signal= false
        close_signal= true
        
        if temp>45
          p "but too HOT!"
          window.now_step=window.steps
          open_signal= true
          close_signal= false
        end
      elsif rain=="0"
        limitter=nil
       
        if limitter
          if window.now_step > (limitter+1)
            unless window.emergency
              open_signal= false
              window.now_step=limitter
            else
            #none
            #full open or close
            end
          end
        end
      else
        p rain
      end
    #end
    
    #controll_command
    
    manual=yaml_dbr("manual_0-0.txt","config/manual_0-0.txt")
    if manual[-1-dif]=="1"
    
      #manual flag load
      manual=yaml_dbr("manual_0-1.txt","config/manual_0-1.txt")
      if manual[-1-dif]=="1"
        open_signal=true
        close_signal=false
        rain="manual"
      elsif manual[-2-dif]=="1"
        open_signal=false
        close_signal=true
        rain="manual"
      else
        open_signal=false
        close_signal=false
        rain="manual"
      end
    end
    if rain=="0"
      step=window.now_step
      #rain=step
    else#rain
      step=0.5
      #rain_=0.5
    end

#p change
    now=[open_signal,close_signal,rain]
    if change != now
      
      change=now
    
      p check_step="#{Time.now.to_s},set:#{window.set_value}:now:#{temp.inspect}:step:#{window.now_step.inspect},open:#{open_signal.inspect},close:#{close_signal.inspect},emargency:#{window.emergency.inspect},#{step.to_s}"
      Loger::loger("log/#{tuple_name}_log.txt",check_step)
      Loger::loger("log/#{tuple_name}_step.txt","#{Time.now.to_s},#{step.to_s}")
      db.set(tuple_name+":step",step)
      db.set(tuple_name,check_step)
      #c=["name",[bool...]]
      #[tuple_name,change]
      begin
        p change
        if now[0] and (!now[1])  
          db.rpush(:numato,"relay off "+close_bit)
          sleep 2
          db.rpush(:numato,"relay on "+open_bit)
          sleep 2
        elsif now[1] and (!now[0])
          db.rpush(:numato,"relay off "+open_bit)
          sleep 2
          db.rpush(:numato,"relay on "+close_bit)
          sleep 2
        else
          db.rpush(:numato,"relay off "+open_bit)
          sleep 2
          db.rpush(:numato,"relay off "+close_bit)
          sleep 2
        end
        
        #$ts.write([tuple_name,change])
      rescue
        p str="ts_window_write error"
        Loger::loger("error_log.txt",Time.now.to_s+","+str)
        sleep 1
        #system("sudo reboot")
      end
      sleep 2
    end
    
    sleep 1.8
    #p t
  end
end
