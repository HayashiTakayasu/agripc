#!ruby

=begin
all on
pi@raspberrypi:~$ sudo i2cset -y 1 0x38 0x00 0x64

all off
pi@raspberrypi:~$ sudo i2cset -y 1 0x38 0x00 0x6e

relays set
0x65-6c on ch(1-8)
0x6f-76 off ch(1-8)
=end

`sudo i2cset -y 1 0x38 0x00 0x64`

#status
p status=`sudo i2cget -y 1 0x38 0x01`.chomp # => "0xff"

require "agri-controller"
include AgriController 

b=Bit.new(status.to_i(16)) # => #<AgriController::Bit:0x1587528 @bit=255> 
b.on?(1)                   # => true 
b.off(1) if b.on?(1) 

=begin
8.times do |i|
  if b.on?(i)
    x=0x65+i
    str="sudo i2cset -y 1 0x38 0x00 0x#{Bit.new(x).tos(2,16)}"
  else
    x=0x6f+i
    str="sudo i2cset -y 1 0x38 0x00 0x#{Bit.new(x).tos(2,16)}"
  end

  p str
  `#{str}`
end
=end
p str="sudo i2cset -y 1 0x38 0x01 0x#{b.tos(2,16)}"
`#{str}`
sleep 0.5
`sudo i2cset -y 1 0x38 0x01 0x00`
