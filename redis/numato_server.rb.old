require "agri-controller"
require "redis"
include AgriController

##redis numato server
#ch0[:numato,"relay on V"]

db=Redis.new

loop do
  while command=db.lpop(:numato)
    p data=Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+command
    
    p str=%!sudo python ./namuto.py "#{command}"!
    p res=`#{str}`
    
    Loger::loger("./log/db.txt",data)
    sleep 0.1
  end
end

