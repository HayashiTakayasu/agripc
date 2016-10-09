command=ARGV[0] #|| "reset"
port=ARGV[1] || "/dev/ttyACM0"
if $DEBUG
p command
p port
end
open(port,"wb"){|io| io.print(command+"\n\r")
res=io.readline
p res
}
#ruby namuto_upr4c.rb "relay on 3"
