require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

db=Redis.new

change=nil
loop do
  p ary=yaml_dbr("time_array","./bin_ac/cgi-bin/config/time_array")
  p wait_time=yaml_dbr("wait_time","./bin_ac/cgi-bin/config/wait_time")
  30.times do
    bit=multiple_pulse_timer(ary,wait_time)
    #p bit.bit
    if change!=bit.bit
      change=bit.bit
      p bit.tos(6,2) 
      db.rpush(:numato,"relay off 0") if bit.off?(0)
      db.rpush(:numato,"relay on 0") if bit.on?(0)
      
      db.rpush(:numato,"relay off 1") if bit.off?(2)
      db.rpush(:numato,"relay on 1") if bit.on?(2)

      if (bit.off?(0)) and (bit.off?(2))#bit.bit==0
        db.rpush(:numato,"relay off 2")
      else
        db.rpush(:numato,"relay on 2")
      end
    end
    sleep 0.8
  end
end
