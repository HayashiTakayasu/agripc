require "agri-controller"
require "redis"
require "./setting_io"
include AgriController

#OYA_ikubyou

db=Redis.new

change=nil
loop do
  p __FILE__
  p ary=yaml_dbr("house9_5","./bin_ac/cgi-bin/config/house9_5")
  30.times do
    bit=timers(ary)
    #p bit.bit
    if change!=bit
      change=bit
      p bit 
      db.rpush(:numato,"relay off U") if bit==false
      db.rpush(:numato,"relay on U") if bit==true

    end
    sleep 0.8
  end
end
