require "timeout"
#require "./ma_vrc_parse"
device=ARGV[0] || '/dev/ttyUSB*'

#device="/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0"

#device="/dev/serial/by-id/usb-FTDI_USB__-__Serial-if00-port0"
#usb-Prolific_Technology_Inc._USB-Serial_Controller-if00-port0
#system("sudo chmod 777 #{device}")

system("sudo chmod 777 /dev/ttyU*")
#begin
#  timeout(10) do
    #x=`ls /dev/ttyUSB*`..chomp
    #p x
    #unless x==""
    #  `python ./ma_vrc_co2.py #{x}`
    #else
    #  break
    #end
    
    ##CentOSLinux_version
    system("python ./ma_vrc_co2.py /dev/ttyUSB0")
    ##raspberryPi version
    #system("python ./ma_vrc_co2.py #{device}")
#  end
#rescue Timeout::Error
#  p "ma_test.rb Timeout::Error.#{Time.now}"
#  str=File.read("./app.pid")
#  p command="kill -9 #{str}"
#  p `#{command}`
#  open("error_ma_test.txt","a+"){|io| io.puts Time.now.to_s+" "+command}
#  retry
#end
#x=File::read("ma.txt")
#if x
#puts res=parse(x)
#end

