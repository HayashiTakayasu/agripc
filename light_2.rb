require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#light

db=Redis.new
name="light_2"
io_bit="U"

change=nil
loop do
  p __FILE__
  p ary=yaml_dbr(name,"./bin_ac/cgi-bin/config/"+name)
  30.times do
    bit=timers(ary)
    #p bit.bit
    if change!=bit
      change=bit
      p bit 
      db.rpush(:numato,"relay off "+io_bit) if bit==false
      db.rpush(:numato,"relay on "+io_bit) if bit==true

    end
    sleep 0.8
  end
end
