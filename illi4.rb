require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new

change=nil
loop do
  p ary=yaml_dbr("house3-2","./bin_ac/cgi-bin/config/house3-2")
  30.times do
    bit=multiple_pulse_timer(ary,10)
    #p bit.bit
    if change!=bit.bit
      change=bit.bit
      p bit.tos(6,2) 
      db.rpush(:numato,"relay off 6") if bit.off?(0)
      db.rpush(:numato,"relay on 6") if bit.on?(0)

    end
    sleep 0.8
  end
end
