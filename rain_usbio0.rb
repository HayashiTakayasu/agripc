require "redis"
db=Redis.new
loop do
  str=`sudo /usr/bin/python ./run_rain_sensor.py`.chomp
  if str=="1"
    sleep 0.3
    str=`sudo /usr/bin/python ./run_rain_sensor.py`.chomp
    if str=="1"
      sleep 0.3
      str=`sudo /usr/bin/python ./run_rain_sensor.py`.chomp
    end
  end
  p str
  str="0" if str=="" #if rain not work

  db.set("rain",str)
  open('./rain.txt',"w"){|io| io.print str}  
  sleep 10
end
