require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new
name="heater_fan"
io_bit=""

change=nil
loop do
  ary=yaml_dbr(name,"./bin_ac/cgi-bin/config/"+name)
  p name+" , "+ary.to_s
  if io_bit!="K"
     30.times do
      #pulseTimer First.
      bit=pulse_timers(ary)
      
      ###other targets
      ##"on","off"
      
      co2=db.get("co2")
      #fan=db.get("fan")
      
      ##high,low
      rh=db.get("humidity").to_f
      housa_=db.get("housa").to_f
      #p [heater,co2,fan,rh,housa_]
#      if heater=="on" or co2=="on" or fan=="on" or (rh>85.0) or (housa_<2.0)
      if co2=="on"
        #p [heater,co2,fan,rh,housa_]
        bit=true
      end
      
      #p bit.bit
      if change!=bit
        change=bit
        p bit 
        #sleep 180 if bit==false  #delay timer
        db.rpush(:numato,"relay off "+io_bit) if bit==false
        db.rpush(:numato,"relay on "+io_bit) if bit==true

      end
    end
  end
  sleep 11
end
