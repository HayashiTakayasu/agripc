require "redis"
db=Redis.new
loop do
  #str=`sudo /usr/bin/python ./run_rain_sensor.py`.chomp
  db.rpush(:numato,"gpio read 0")
  str=db.get(:rain)
#  if str=="1"
#    sleep 0.3
#    db.rpush(:numato,"gpio read 0")
#    str=db.get(:rain)
#  end
  p str
  str="0" if str=="" #if rain not work

  open('./rain.txt',"w"){|io| io.print str}  
  sleep 10
end
