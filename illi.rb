require "agri-controller"
require "redis"
include AgriController

db=Redis.new

change=nil
p ary=[[[120,120,120,120],["19:12:00",5]],10]
loop do
  bit=multiple_pulse_timer(*ary)
  if change!=bit.bit
    change=bit.bit
    p bit.tos(8,2)
    db.rpush(:numato,"00") if bit.off?(0)
    db.rpush(:numato,"01") if bit.on?(0)
    db.rpush(:numato,"10") if bit.off?(2)
    db.rpush(:numato,"11") if bit.on?(2)
    db.rpush(:numato,"20") if bit.off?(4)
    db.rpush(:numato,"21") if bit.on?(4)
    db.rpush(:numato,"30") if bit.off?(6)
    db.rpush(:numato,"31") if bit.on?(6)
  end
  sleep 1
end
