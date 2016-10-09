require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

db=Redis.new
name="boiler"
heater_bit="O"
degree_ref="soil_temp"

ary_before=nil
change=nil
obj=nil
loop do
  ary=yaml_dbr(name,"./bin_ac/cgi-bin/config/"+name)
  p name+" : "+ary.to_s
  if ary!=ary_before
    obj=N_dan_thermo.new(ary,diff=1,dead_time=10,changed_time=Time.now)
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
    bit=obj.cool?(degree)
    #p bit.bit
    if change!=bit
      p change=bit
      p obj.set_now
      p degree
      #sleep 180 if bit==false  #delay timer
      db.rpush(:numato,"relay off "+heater_bit) if bit==false
      db.set("boiler","off") if bit==false
      
      db.rpush(:numato,"relay on "+heater_bit) if bit==true
      db.set("boiler","on") if bit==true
    end
    sleep 5
  end
end
