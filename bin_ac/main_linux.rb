#!ruby
#coding:utf-8
#$KCODE="u" if RUBY_VERSION < "1.9.0"

##
#a=Thread.start{thermo_gruff_loop}
#a=Thread.start{thermo_gruff_loop(false,"./htdocs/thermo","./cgi-bin/log",5,"480x420","220x250")}
p "main_linux (since 2011/09/27)"
#load "./save_threads.rb"
require "thread"
module AgriController
  module_function
  def thermo_read(ref="http://maru.selfip.com/cgi-bin/thermo.rb")
    begin
      uri=URI(ref)
      dat=uri.read("Accept-Language" => "ja")
    rescue
      nil
    end
  end
  
  #main_for_proto_house
  def main_linux(log="./cgi-bin/log",config="./cgi-bin/config",docs="./htdocs/thermo",dacs_port="/dev/ttyUSB0")
    
    log_time=Time.now
    Thread.abort_on_exception=true
        #dacs port
          dacs_port="/dev/ttyUSB1"
        #WR1010
        #thermo_thread starts
        yaml_file="last_thermo_data"
        wr_port="/dev/ttyUSB0"
        thermo_port=wr_port#8#6
        thermo_N=5
        baud=57600
        
        a=Thread.start{thermo_gruff_loop(true,"./htdocs/thermo","./cgi-bin/log",thermo_N,"450x400","220x250")}
        
        th="thermo_define.yml"
        yaml_db(th,[thermo_port,thermo_N],config+"/"+th)
        
        #thermo_loop_thread(yaml_file,thermo_port,thermo_N,sec=30)
        thermo_loop_thread(yaml_file,thermo_port,thermo_N,sec=30,"./cgi-bin/config",baud)
        
        #thermo_logger_thread starts
        thermo_data_logger_thread(thermo_N,"./cgi-bin/config","./cgi-bin/log")
#p "1"    
    #reset manual bool
    #yaml_db("manual_bool01.txt",nil,config+"/manual_bool01.txt")
    #yaml_db("manual_bool02.txt",nil,config+"/manual_bool02.txt")
    yaml_db("manual_dacs0-0.txt",0,config+"/manual_dacs0-0.txt")
    yaml_db("manual_dacs0-1.txt",0,config+"/manual_dacs0-1.txt")
    sleep 0.1
    
    loop do
      catch :reset_signal do
        sleep 0.2
        #p "reset"
        ##
        #Initialize basic DATA
        manual_config =Bit.new(0)#15 & 9 => 9 (AND)
        manual_bit=Bit.new(0)#15 | 9 => 15 (OR)
        res=nil
        dacs=Serial.new("W0000000\r",dacs_port)
        dacs.time_out=1
        dacs.set
#p "2"
        #dacs
        res=dacs.serial
        unless res
        sleep 0.5
        p "twice"
          res=dacs.serial
        end
        p res
#p "3"  
        p res_i=Dacs::toi(res)
        p thermo_N
        p WR1010::send_sample(thermo_N)
        wr=Serial.new(WR1010::send_sample(thermo_N),wr_port,baud,5)
        wr.set
        # res=nil
        #res=Dacs::dacs(dacs_port,"W0000000\r")
        #p res
        #res_i=Dacs::toi(res)
        
        #wr=Serial.new(WR1010::send_sample,wr_port,9600,5)
        #wr.set
        
        #thermo=toa(wr.serial)
        #THERMO port
          #wr1010 thrmo request
          thermo=yaml_dbr("last_thermo_data",config+"/last_thermo_data")#WR1010::list(thermo_port,thermo_N)      
          
        #BIT SETTING
             
          dacs_bit=Bit.new        
          in_bits=Bit.new(res_i || 0) ##import signal(dacs)      
          change1=false 
          p house1_set=yaml_dbr("house1",config+"/house1")
          house2_set=yaml_dbr("house2",config+"/house2")
          house3_set=yaml_dbr("house3",config+"/house3")
          
           house1=N_dan_thermo.new(house1_set,diff=1,10)
           house2=N_dan_thermo.new(house2_set,diff=1,10)
           house3=N_dan_thermo.new(house3_set,diff=1,10)
                
                a=Value_controller.new(steps=4,open_sec=50,#55
                down_sec=40,#35,
                  sensitivity=2,set_value=17,dead_time=15)
                  p "house1 Starts at #{(a.up_sec*a.steps).to_s} sec later."
                
                b=Value_controller.new(steps=4,open_sec=50,#55
                  down_sec=40,#35,
                  sensitivity=2,set_value=17,dead_time=15)
                #p "house2 Starts at #{b.reset_time.to_s}(#{(b.up_sec*b.steps).to_s} sec later)."
                
                c=Value_controller.new(steps=4,open_sec=50,#55
                  down_sec=40,#35,
                  sensitivity=2,set_value=17,dead_time=15)
                #p "house2 Starts at #{b.reset_time.to_s}(#{(b.up_sec*b.steps).to_s} sec later)."
      
      #wet_sensor SETTING
        line0=Wet_sensor.new
        line1=Wet_sensor.new
        line2=Wet_sensor.new
        #line3=Wet_sensor.new
      #illigate Time DEFINE[[10,7,6,3],["17:42"],["17:43"],["18:00"]]
        time_array3=yaml_dbr("time_array",config+"/time_array")
        puts "watering set:#{time_array3.inspect}"
        wait_time=yaml_dbr("wait_time",config+"/wait_time")
      
      #start
        start=Time.now
        
        #start time logging
        dat="Start,"+Time.now.iso8601
        Loger::loger(config+"/last_bit.txt",dat+"<br/>","w")#Start,#{Time.now}<br/>
        Loger::loger(log+"/log.txt",dat)
        
        #value_controller step change initialize
        change_step=[false,false]
        
        ##
        #MAIN LOOP (break if in_bit(22)==off)
        run_save_flag=nil
        
        loop do
            t=Time.now
            time=t.iso8601
            #illigate Timer
            x=multiple_pulse_timer(time_array3,wait_time)              
              
              if t.min!=run_save_flag
                run_save_flag=t.min
                #save_run_check_time
                begin 
                  yaml_db("run_check",t,config+"/run_check")
                #retry if error.
                rescue
                  sleep 0.1
                  yaml_db("run_check",t,config+"/run_check")
                end
              end
              
              if yaml_dbr("reload_flag",config+"/reload_flag")==true
                yaml_db("reload_flag",false,config+"/reload_flag")
                p dat="reload signal:"
                Loger::loger(log+"/log.txt",dat)
                
                sleep 0.1
                throw :reset_signal
              end
                
              #thermo DEFINE
                thermo=nil
                thermo=yaml_dbr("last_thermo_data",config+"/last_thermo_data")
              #last_thermo_time

              #p x
              #x.bit =>Integer
              if (x.bit)!=0 #sensor work
                dacs.command="W0\r"
                res=nil
                res=dacs.serial
                #unless res
                #  res=dacs.serial
                #end
                #p res.class
                #p dacs if res.class != String
              #  res_i=Dacs::toi(res)
              #  in_bits.bit=(res_i || 0)
              end
              #if (x.bit)!=0 #sensor work
              #  res=Dacs::dacs(dacs_port,"W0\r")
                #command="W0\r"
                #res=nil
                #res=dacs.serial
                #unless res
                #  #res=dacs.serial
                #end
                #p res.class
                #p dacs if res.class != String
                res_i=Dacs::toi(res)
                in_bits.bit=(res_i || 0)
              #end
             
              
              
              #wet sensor work
              #illigating check
              #dacs_bit.boolbit(x.on?(2),0)#signal switch
              i0=line0.keeper(x.on?(0),in_bits.on?(0))
              dacs_bit.boolbit(i0,1)#illigate line1
              #dacs_bit.boolbit(x.on?(0),5)#signal switch
              
              i1=line1.keeper(x.on?(2),in_bits.on?(1))
              dacs_bit.boolbit(i1,2)#illigate line2          ##
              #dacs_bit.boolbit(x.on?(2),6)#signal switch
              
              i2=line2.keeper(x.on?(4),in_bits.on?(2))
              dacs_bit.boolbit(i2,3)#illigate line3
              #dacs_bit.boolbit(x.on?(4),7)#signal switch
              
              #i3=line3.keeper(x.on?(6),in_bits.on?(0))
              #dacs_bit.boolbit(i3,4)#illigate line4          ##
              #dacs_bit.boolbit(x.on?(6),8)#signal switch
              
              pomp =  (i0) | (i1) | (i2) #| (i3)#x.on?(0) | x.on?(2)
              dacs_bit.boolbit(pomp,0)         # pomp signal
              dacs_bit.boolbit((x.bit)==0,23)  # not water working(tank valve.)
              
              
              #motor bit
              step_str=""
              if thermo.class==Array && thermo.size==thermo_N
                
                #set_temp from N_dan_thermo
                a.set_value=house1.set_now
                b.set_value=house2.set_now
                c.set_value=house2.set_now
                ##
#if thermo error,change here algorithm
                #Controll
                bit1=a.value_controll(thermo[0][0]) if thermo[0][0] != nil
                bit2=!a.switch
                bit3=b.value_controll(thermo[1][0]) if thermo[1][0] != nil
                bit4=!b.switch
                bit5=c.value_controll(thermo[2][0]) if thermo[2][0] != nil
                bit6=!c.switch
                
                
                check_step=[a.now_step,b.now_step,c.now_step]
                
                if check_step != change_step
                  string=[a.set_value,b.set_value,c.set_value].inspect#+check_step.inspect
                  #p [bit1,bit2,bit3,bit4]
                  #p thermo
                  
                  step_str=",step:"+a.now_step.to_s+","+"step:"+b.now_step.to_s+","+"step:"+c.now_step.to_s+","+string
                  yaml_db("change_step",check_step,config+"/change_step")
                  
                  change_step=check_step.dup
                end
              else
              #2010.4.28 changed 
                
                ##
                #commonly open if thrmo error.
                #house1
                bit1=true #open signal
                bit2=false#motor_off_trap
                
                ##
                #commonly open if thrmo error.
                #house2
                bit3=true #open signal
                bit4=false#motor_off_trap
                #commonly open if thrmo error.
                
                ##
                #house3
                bit5=true #open signal
                bit6=false#motor_off_trap
                
                #dat=Time.now.to_s+":thermo_error!! open full time."+thermo.inspect
              end
              #house1 motor
              dacs_bit.boolbit(bit1,6)
              dacs_bit.boolbit(bit2,7)
              #house2 motor
              dacs_bit.boolbit(bit3,8)
              dacs_bit.boolbit(bit4,9)
              #house3 motor
              dacs_bit.boolbit(bit5,10)
              dacs_bit.boolbit(bit6,11)
              
              
              
              ##
              #RESULT BIT OUTPUT IF CHANGED
              #sum bits and check changes
          #dacs_bit auto
          #p change1
          
          #p config+"/manual_bool01.txt"
          #p yaml_dbr("manual_bool01.txt",config+"/manual_bool01.txt")
          #if yaml_dbr("manual_bool01.txt",config+"/manual_bool01.txt")==nil
          #if yaml_dbr("manual_dacs0-0.txt",config+"/manual_dacs0-0.txt")!=0
              manual_config.bit=yaml_dbr("manual_dacs0-0.txt",config+"/manual_dacs0-0.txt").to_i# => 0..2**24
              manual_bit.bit=yaml_dbr("manual_dacs0-1.txt",config+"/manual_dacs0-1.txt").to_i# => 0..2**24
              
              if manual_config.bit!=0
                (0..23).each do |x|
                  dacs_bit.boolbit(manual_bit.on?(x),x) if manual_config.on?(x)
                end             
              end
          str=dacs_bit.tos(24,2)
          
              if change1 != dacs_bit.bit
                change1=dacs_bit.bit
                #p time
                #str=dacs_bit.tos(24,2)
                #p thermo
                begin
                  if thermo!=nil or thermo.size>=2
                    p data=str+","+time+","+
                  thermo[0][0].to_s+","+thermo[0][1].to_s+","+thermo[1][0].to_s+","+thermo[2][0].to_s+step_str
                  else
                    p data=str+","+time
                  end
                rescue
                   data=str+","+time
                end
                  
                #logging thread
                #Thread.start(data){|dat|
                  
                  Loger::loger(config+"/last_bit.txt",data+"<br/>","w")
                  Loger::loger(log+"/log.txt",data)
                #}
               #str=bits.tos(24,2)
               #str_size=str.size
              
              ##
              #command output
               #hex0=str
               #hex=Bit.new(hex0.to_i(2)).tos(6,16)

                #command="W0"+hex+"\r"
                #dacs.command = (command)

                #res=nil
                #res=dacs.serial
                #unless res
                #  res=dacs.serial
                #end
                #p dacs if res.class != String
              #command output
               hex0=str
               hex=Bit.new(hex0.to_i(2)).tos(6,16)

                command="W0"+hex+"\r"
                dacs.command = (command)

                res=nil
                res=dacs.serial
                unless res
                  res=dacs.serial
                end
                p dacs if res.class != String
                
                
                res_i=Dacs::toi(res)
                in_bits.bit=(res_i || 0)
                
                #res=Dacs::dacs(dacs_port,command)
                #unless res #retry
                #  sleep 1
                #  res=Dacs::dacs(dacs_port,command) 
                #  p "dacs retry:"+res.inspect
                #end
                
                if res.class != String
                  message=Time.now.iso8601+"|Dacs response ERROR|,"+command.chomp+","+res.inspect.chomp#+"<br/>"
                  p message
                  #Loger::loger(log+"/../log/errors.txt",message)
                  Loger::loger(log+"/../log/errors_.txt",message)
                end
                Loger::loger(log+"/kr_command_log.txt",time+","+command.chomp+","+res.inspect.chomp)
                
                res_i=Dacs::toi(res)
                in_bits.bit=(res_i || 0)
              end
          
          if t.sec%5==3
            #p res=Dacs::dacs(dacs_port,command)
            #p time+","
            #p str
            #dacs_bit.blink(23)
            
            str=dacs_bit.tos(24,2)
            hex0=str
            hex=Bit.new(hex0.to_i(2)).tos(6,16)
              
            command="W0"+hex+"\r"
            dacs.command = (command)
            res=nil
            res=dacs.serial
            p time+","+command+","+res.inspect if $DEBUG
          end
  
          if log_time.hour != t.hour
            log_time=t.dup
            p "watchdog:"+time
          end
          
          sleep 0.8
          
          #p Time.now-t if $DEBUG
          
          #p Thread.list
          #raise
        end #main_loop
      end   #catch reset_signal
    
    end     #reset_loop
    #q.push nil
    #queue.join
    a.join
  end
end
#AgriController::main_new
