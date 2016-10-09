require "redis"
db=Redis.new(:host=>"192.168.11.200",:port=>6379)
db2=Redis.new
ls=[:degree,:housa,:humidity,:last_time,:ppm,:rain,:soil_temp,:roten,:zettai]

#ls2=db.mget(ls)
loop do
  #str=`sudo /usr/bin/python ./run_rain_sensor.py`.chomp
  ls2=db.mget(ls) #copy elements
  ls.size.times{|i| db2.set(ls[i],ls2[i])}

  str=db2.get(:rain)
#  if str=="1"
#    sleep 0.3
#    db.rpush(:numato,"gpio read 0")
#    str=db.get(:rain)
#  end
  p "rain:"+str
  str="0" if str=="" #if rain not work
  db.set(:time,Time.now.strftime("%X")) #set time (slave_sensor_device)
  open('./rain.txt',"w"){|io| io.print str}  
  sleep 5
end
