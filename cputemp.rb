#require "time"
#sudo cat /sys/class/thermal/thermal_zone0/temp
temp=(`sudo cat /sys/class/thermal/thermal_zone0/temp`.to_f/1000).round(2).to_s
date=Time.now.strftime("%Y-%m-%d %H:%M:00")
print date+","+temp+"\n"
