require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new
name="fan"
io_bit="K"
degree_ref="degree"

ary_before=nil
change=nil
fan=nil
loop do
  ary=yaml_dbr(name,"./bin_ac/cgi-bin/config/"+name)
  p name+ " , "+ary.to_s
  if ary!=ary_before
    fan=N_dan_thermo.new(ary,diff=1,dead_time=5,changed_time=Time.now)
    degree=fan.set_now.to_s
    db.set("fan_set_now",degree)
    #p fan.list
    ary_before=ary
  end
  6.times do
    degree=db.get(degree_ref).to_f
    ###other targets
    ##"on","off"
    #heater=db.get("heater")
    #co2=db.get("co2")
    
    ##high,low
    #rh=db.get("usbrh:humidity").to_f
    #housa_=db.get("housa").to_f
    
    #if heater=="on" or co2=="on" or (rh>85.0) or housa_<2.0
    #  bit=true
    #end
    bit=fan.hot?(degree)
    #p bit.bit
    if change!=bit
      p change=bit
      p fan.set_now
      p degree
      #sleep 180 if bit==false  #delay timer
      db.rpush(:numato,"relay off "+io_bit) if bit==false
      db.set(name,"off") if bit==false
      
      db.rpush(:numato,"relay on "+io_bit) if bit==true
      db.set(name,"on") if bit==true
    end
    sleep 5
  end
end
