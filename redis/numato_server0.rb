require "agri-controller"
require "redis"
include AgriController

##redis numato server
#ch0[:numato,"relay on V"]

db=Redis.new
#reset at first
db.rpush(:numato,"reset")
sleep 5

db.set("numato_bit","0")
bit=Bit.new(0)
manual_0=db.get("manual_0")
manual_1=db.get("manual_1")

#set to numato32 
manual.size.times do |i| 
 bool=manual_0[i*-1-1]
 if bool=="1"
   if manual_1[i*-1-1]=="1"
     db.rpush(:numato,"relay on #{i.to_s(36.upcase)}")
     bit.on(i)
     p i
     db.set("numato_bit",bit.tos(32,2))
   end
 end
end
p db.get("numato_bit")

loop do
  while command=db.lpop(:numato,time_out=0.1)
    if command
      p data=Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+command
      
      p str=%!sudo python ./namuto.py "#{command}"!
      p res=`#{str}`
    
      Loger::loger("./log/db.txt",data)
    end
    
    sleep 0.1
  end
end

