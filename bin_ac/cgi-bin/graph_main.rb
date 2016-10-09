#!ruby
#coding:utf-8
#require "agri-controller"
#include AgriController
#include WR1010
module AgriController
  module_function
  def graph_main
    #start time logging
    #p str=reload
    log="./cgi-bin/log"
    config="./cgi-bin/config"
    
    p dat="Start,"+Time.now.to_s
          #thermo_thread starts
          yaml_file="last_thermo_data"
          
          thermo_port=1#6
          thermo_N=4
          th="thermo_define.yml"
          yaml_db(th,[thermo_port,thermo_N],config+"/"+th)
          
          #thermo_loop_thread(yaml_file,thermo_port,thermo_N,sec=30)
          thermo_loop_thread(yaml_file,thermo_port,thermo_N,sec=30,"./cgi-bin/config")
          
          #thermo_logger_thread starts
          thermo_data_logger_thread(thermo_N,"./cgi-bin/config","./cgi-bin/log")
        #start
          start=Time.now
          
          #start time logging
          dat="Start,"+Time.now.to_s
          Loger::loger(config+"/last_bit.txt",dat+"<br/>","w")#Start,#{Time.now}<br/>
          Loger::loger(log+"/log.txt",dat)
          run_save_flag=nil
    
    #MAIN LOOP (break if in_bit(22)==off)
    loop do
      #time=(Time.now).to_s
              t=Time.now
              time=t.to_s
          yaml_db("run_check",time,config+"/run_check")
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
          #thermo DEFINE
                #thermo DEFINE
                #  thermo=nil
                #  thermo=yaml_dbr("last_thermo_data",config+"/last_thermo_data")
        sleep 1
    end
  end
end
