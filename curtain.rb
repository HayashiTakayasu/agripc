require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new

change=nil
loop do
  p ary=yaml_dbr("house11","./bin_ac/cgi-bin/config/house11")
  30.times do
    bit=timers(ary)
    #p bit.bit
    if change!=bit
      change=bit
      p bit 
      if bit#on
        db.rpush(:numato,"relay off E")
        sleep 1
        db.rpush(:numato,"relay off G")
        sleep 1 
        db.rpush(:numato,"relay on D")
        sleep 1
        db.rpush(:numato,"relay on F") 
      else#off
        db.rpush(:numato,"relay off D")
        sleep 1
        db.rpush(:numato,"relay off F")
        sleep 1 
        db.rpush(:numato,"relay on E")
        sleep 1
        db.rpush(:numato,"relay on G") 
      end
    end
    sleep 0.8
  end
end
