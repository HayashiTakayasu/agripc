require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new

change=nil
loop do
  p ary=yaml_dbr("time_array2","./bin_ac/cgi-bin/config/time_array2")
  30.times do
    bit=multiple_pulse_timer(ary)
    #p bit.bit
    if change!=bit.bit
      change=bit.bit
      p bit.tos(6,2) 
      db.rpush(:numato,"relay off 4") if bit.off?(0)
      db.rpush(:numato,"relay on 4") if bit.on?(0)
    end
    sleep 0.8
  end
end
