  require "rubygems"
  require "agri-controller"
  require "./housa"
  require "redis"

  
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
  def thermo_data_logger_thread
        #begin
        #mainloop
        before=nil
        db=Redis.new        
        loop do
          t=Time.now
          min=t.min
          if min!=before
            before=min
            begin
            #system("ruby ./rh_test_s0.rb")
            rescue
            end
            #str=File.read("rh.txt")
            #mh=str.split(" ")

            t2=t.to_a
            t2[0]=0
            tt=Time.parse(t2[2].to_s+":"+t2[1].to_s+":"+t2[0].to_s)
            
            ##
            #save DATA LOGGER(default,each o'clock)
            #housa_=housa(mh[0].to_f,mh[1].to_f).round(2).to_s
            #read other thermos
            ls=[:degree,:housa,:humidity,:last_time,:ppm,:rain,:soil_temp,:roten,:zettai]
            #read CO2 data
            sleep 10
            ppm=db.get("ppm")
            degree=db.get("degree")
            humidity=db.get("humidity")
            housa_=db.get("housa")
            soil_temp=db.get("soil_temp")
            
            p word=tt.strftime("%Y-%m-%d %H:%M:%S")+","+
            degree+","+
            humidity+","+
            ppm+", "+
            housa_+","+
            soil_temp+", "+
            db.get("usbrh1:degree").to_f.to_s+","+
            db.get("usbrh1:humidity").to_f.to_s+","+
            db.get("usbrh1:housa").to_f.to_s+", "+
            
            db.get("usbrh2:degree").to_f.to_s+","+
            db.get("usbrh2:humidity").to_f.to_s+","+
            db.get("usbrh2:housa").to_f.to_s+", "+
            
            db.get("usbrh3:degree").to_f.to_s+","+
            db.get("usbrh3:humidity").to_f.to_s+","+
            db.get("usbrh3:housa").to_f.to_s           

        
            #seve data each minute.
            #usbrh_degree

             yield word if block_given?
         end

          sleep 0.3
          #p Time.now
        end

  end
if $0==__FILE__
  require "rubygems"
  require "agri-controller"
#]  require "./debug/error_caption"
  include AgriController

  #include Loger
  p "start rh_puts_db.rb"
  
  loop{error_catch("./error_log",15,""){
    thermo_data_logger_thread do |data|
      Loger::loger("./thermo_data/thermo_data2.csv",data)
      Loger::loger("./thermo_data/thermo_data2.txt",data)
      #.copy("./thermo_data.csv","./thermo_data")
      open("./last_data2","w"){|io| io.puts data}
      open("./last_data2.txt","w"){|io| io.puts data}
    end
    }
  }
end

