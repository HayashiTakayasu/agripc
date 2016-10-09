#!/bin/sh
pwd
#cd /home/agri/Desktop/ma
cd /home/pi/Desktop/ma

##
#maのデータロガー
#
#xterm -e ruby main_ma.rb &
#xterm -e ruby ./controll_loop.rb &

sudo rmmod ftdi_sio
#ruby ./cp_mes.rb

##graphic work too busy...
#lxterminal -e ruby ./main_ma.rb &

##
#controlls
lxterminal -e /home/pi/.rvm/bin/ruby ./controll_loop.rb &

#midori ./graphs.htm &
#firefox ./graphs.htm &

#xterm -e ruby ./ma_puts_s0.rb
lxterminal -e /home/pi/.rvm/bin/ruby ./ma_puts_s0.rb

