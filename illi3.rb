require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new

change=nil
loop do
  p ary=yaml_dbr("time_array3","./bin_ac/cgi-bin/config/time_array3")
  30.times do
    bit=multiple_pulse_timer(ary,10)
    #p bit.bit
    if change!=bit.bit
      change=bit.bit
      p bit.tos(6,2) 
      db.rpush(:numato,"relay off 5") if bit.off?(0)
      db.rpush(:numato,"relay on 5") if bit.on?(0)
      
#      db.rpush(:numato,"relay off 6") if bit.off?(2)
#      db.rpush(:numato,"relay on 6") if bit.on?(2)

    end
    sleep 0.8
  end
end
