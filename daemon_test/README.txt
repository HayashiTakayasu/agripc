#!/bin/sh

cd `dirname $0`
echo `dirname $0`
##
#mchのデータロガー
#
#sudo rmmod ftdi_sio
/home/pi/.rvm/bin/ruby ./messages/cp_mes.rb &
#/home/pi/.rvm/bin/ruby ./rain.rb &


#xterm -e ruby ./ma_puts_s0.rb
lxterminal -e /home/pi/.rvm/bin/ruby ./mh_puts.rb &

#controlls
lxterminal -e /home/pi/.rvm/bin/ruby ./controll_loop.rb &

##graphic work (but too busy...)
lxterminal -e /home/pi/.rvm/bin/ruby ./main_ma.rb &

sleep 10
lxterminal -e /home/pi/.rvm/bin/ruby ./tuple.rb &

cd ../../
lxterminal -e /usr/bin/python ./run_simple_cgi.py &
#/usr/bin/python -m CGIHTTPServer 8000 &
sleep 1
#midori ./graphs.htm &
#firefox ./graphs.htm &
##graphic work (but too busy...)
firefox 127.0.0.1:8000/cgi-bin/main.cgi &


