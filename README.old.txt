#!/bin/sh
#cd /home/agri/Desktop/ma
cd `dirname $0`

##
#maのデータロガー
#
#xterm -e ruby main_ma.rb &
#xterm -e ruby ./controll_loop.rb &

./db/redis-server ./db/redis.conf &
sleep 5
cd ../redis
lxterminal -e /home/pi/.rvm/bin/ruby numato_server.rb &
sleep 5
cd -
/home/pi/.rvm/bin/ruby ./messages/cp_mes.rb &



cd ../bin_ac
lxterminal -e /home/pi/.rvm/bin/ruby ./server.rb &
cd -
#sudo rmmod ftdi_sio

#ruby ./cp_mes.rb

##graphic work too busy...


##
#controlls
#lxterminal -e /home/pi/.rvm/bin/ruby ./controll_loop.rb &

#midori ./graphs.htm &
#firefox ./graphs.htm &

#xterm -e ruby ./ma_puts_s0.rb 

lxterminal -e /home/pi/.rvm/bin/ruby ./tuple.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./rain.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./usbrh_loop.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./ma_puts_ac.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./rh_puts_ac.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./cputemp_loop.rb &

#lxterminal -e /home/pi/.rvm/bin/ruby ./illi1.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./illi2.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./illi3.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./illi4.rb &

#lxterminal -e /home/pi/.rvm/bin/ruby ./controller_window.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./controller_window2.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./controller_window3.rb &

#lxterminal -e /home/pi/.rvm/bin/ruby ./curtain.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./fan.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./co2.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./heater.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./circulator.rb &

#lxterminal -e /home/pi/.rvm/bin/ruby ./light.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./light2.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./light3.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./light4.rb &
#lxterminal -e /home/pi/.rvm/bin/ruby ./light5.rb &

#lxterminal -e /home/pi/.rvm/bin/ruby ./main_ma.rb &
firefox  127.0.0.1:10080/main &
