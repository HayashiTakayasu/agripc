require "timeout"

str=""
begin
  timeout(10) do
    str=`sudo ./usbrh;echo $?`.chomp
  end
rescue Timeout::Error
  p "rh_test.rb Timeout::Error.#{Time.now}"
  str=File.read("./app.pid")
  open("error_rh.txt","a+"){|io| io.puts Time.now.to_s+" "+"usbnrh_error"}
#  retry
rescue
  str=""
end

p str

unless str.include?("USBRH not found") or str=="" or str=="126"
  open("./rh.txt","w"){|io| io.print str.chop.chop}
else 

end
