require "redis"

db201=Redis.new(:host=>"192.168.11.201",:port=>6379)
db200=Redis.new(:host=>"192.168.11.200",:port=>6379)
db199=Redis.new
ls=[:degree,:housa,:humidity,:last_time,:ppm,:rain,:soil_temp,:roten,:zettai]
#[:degree,:housa,:humidity,:last_time,:ppm,:rain,:soil_temp,:roten,:zettai]
#ls2=db.mget(ls)

loop do
  #str=`sudo /usr/bin/python ./run_rain_sensor.py`.chomp
  ls3=db201.mget(ls)
p "house1"
p ls3
  ls.size.times{|i| db199.set(ls[i].to_s+"_1",ls3[i])}

  ls2=db200.mget(ls) #copy elements
p "house2"
p ls2
  ls.size.times{|i| db199.set(ls[i].to_s+"_2",ls2[i])}
  ls.size.times{|i| db199.set(ls[i],ls2[i])} #base 192.168.11.200 (have rain sensor)
  str=db199.get("rain")
#  if str=="1"
#    sleep 0.3
#    db.rpush(:numato,"gpio read 0")
#    str=db.get(:rain)
#  end
  p "rain:"+str
  str="0" if str=="" #if rain not work
  #db200.set(:time,Time.now.strftime("%X")) #set time (slave_sensor_device)
  open('./rain.txt',"w"){|io| io.print str}  
  p db199.keys.sort
  sleep 5
end
