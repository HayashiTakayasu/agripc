#!/bin/sh
#cd /home/agri/Desktop/ma
cd `dirname $0`

./db/redis-server ./db/redis.conf &
sleep 5

cd ./redis
lxterminal -e /home/pi/.rvm/bin/ruby numato_server.rb &
sleep 5
cd -
/home/pi/.rvm/bin/ruby ./messages/cp_mes.rb &



cd ./bin_ac
lxterminal -e /home/pi/.rvm/bin/ruby ./server.rb &
cd -

lxterminal -e /home/pi/.rvm/bin/ruby ./tuple.rb &
firefox  127.0.0.1:10080/main &
