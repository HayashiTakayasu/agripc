require "rubygems"
require "agri-controller"
include AgriController
  if RUBY_PLATFORM.include?("linux")
      b=Bit.new(rand(2**24))
      #b=Bit.new(2**24-1)
     str=b.tos(6,16)
     a=Serial.new
     a.port="/dev/ttyUSB1"
     a.speed=9600
     a.command="W0"+str+"\r"#"W0FFFFFF\r"
    p a
    p a.serial
    sleep 0.2
    #p a.serial
  end

