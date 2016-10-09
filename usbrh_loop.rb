require "agri-controller"
require "redis"
include AgriController
url1="http://192.168.2.114:8000/bin/product/last_data.txt"
url2="http://192.168.2.107:8000/bin/product/last_data.txt"
url3="http://192.168.2.111:8000/bin/product/last_data.txt"

def parse(res)
  begin
    ary=res.chomp.split(",")
  
    if ary.size >= 4
      return [ary[1],ary[2],ary[4]]
    else
      nil
    end
  rescue
    nil
  end
end
def db_set(rh,name)
  db=Redis.new
  i=parse(rh)
  if i
    p i
    db.set("#{name}:degree",i[0])
    db.set("#{name}:humidity",i[1])
    db.set("#{name}:housa",i[2])
  else
    p "0"
    db.set("#{name}:degree","0")
    db.set("#{name}:humidity","0")
    db.set("#{name}:housa","0")
    
  end
end

loop do
  rh=thermo_read(url1)
  db_set(rh,"usbrh1")
  sleep 1
  
  rh=thermo_read(url2)
  db_set(rh,"usbrh2")
  sleep 1
  
  rh=thermo_read(url3)
  db_set(rh,"usbrh3")
  
  puts
  
  sleep 30
end
