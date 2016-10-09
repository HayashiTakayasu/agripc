#p Dir.pwd
  require "rubygems"
  require "agri-controller"
  require "redis"
  db=Redis.new
#`ruby mh383_test_win.rb COM6`
#str=File.read("mch.txt")
#require "logger"

module Loger2
  module_function
  def loger(log_file,msg,mode='daily')
    #add data to log_file
    logger=Logger.new(log_file,mode)
    logger.formatter=proc{|severity,datetime,progname,msg| "#{msg}\n"}
    logger.info(msg)
  end
end
#include Loger
  require "time"
  require "fileutils"
  require "timeout"
  load "./ma_vrc_parse.rb"
  def thermo_data_logger_thread
        #begin
        #mainloop
        before=nil
        
        loop do
          t=Time.now
          min=t.min
          if min!=before
            before=min
            system("ruby ma_test_s0.rb")
            str=File.read("./ma.txt")
            
            mh=parse(str)
            counter=0
            #if failed retry ,and reboot.
            while mh=={} or mh.keys.size<3
              sleep 5
              str="#{Time.now.to_s},read failed#{str},#{mh}"
              #Loger2::loger("./error_log",str)
              #retry
              system("ruby ma_test_s0.rb")
              str=File.read("ma.txt")
              
              mh=parse(str)
              counter+=1
              if counter>5
                #Loger2::loger("./error_log.txt","#{Time.now.to_s},ma_puts no response.please reboot.")
                #sleep 30
                #system("sudo reboot")
              end

            end
            
            if mh
            #mh.class
            t2=t.to_a
            t2[0]=0
            tt=Time.parse(t2[2].to_s+":"+t2[1].to_s+":"+t2[0].to_s)
            #p tt
            ##
            #save DATA LOGGER(default,each o'clock)
            degree=mh["2"][0].round(2).to_s
            ppm=(mh["3"][0]).to_s
            
            p word=tt.strftime("%Y-%m-%d %H:%M:%S")+", "+
            degree+", "+
            (mh["1"][0]).round(2).to_s+", "+
            ppm
            open("./thermo_data/degree.txt","w"){|io| io.print degree}
            open("./thermo_data/ppm.txt","w"){|io| io.print ppm}
            #seve data each minute.
             yield word if block_given?
            else
              p "ma parse failed"
            end
          end
          sleep 0.3
          #p Time.now
        end
          
        #sleep 10
    #end
  end
if $0==__FILE__
  require "rubygems"
  require "agri-controller"
  require "./debug/error_caption"
  include AgriController
  #include Loger
  p "start #{__FILE__}"
  
  loop{error_catch("./error_log",15,""){
    thermo_data_logger_thread do |data|
      Loger::loger("./thermo_data/thermo_data.csv",data)
      Loger::loger("./thermo_data/thermo_data.txt",data)
      #.copy("./thermo_data.csv","./thermo_data")
      open("./last_data","w"){|io| io.puts data}
      open("./last_data.txt","w"){|io| io.puts data}
    end
    }
  }
end

