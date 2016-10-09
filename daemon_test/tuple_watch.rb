Dir.chdir(File.dirname(__FILE__))
def log(file,str)
  p str
  open(file,"a+"){|io| io.puts Time.now.strftime("%Y-%m-%d %H:%M:%S")+","+str}
  
end

def exec_rb(filename,sleep_sec=0,dir="./",test=true)
  base=Dir.pwd
  Dir.chdir(dir)
  log("log.txt",filename)
  p str="lxterminal -e /home/pi/.rvm/bin/ruby #{dir+filename}"
  system(str) unless test
  sleep sleep_sec
end

str=`ps aux |grep ruby`
#ls=["mh_puts.rb","controll_loop.rb","main_ma.rb"]
p ls=["usbrh_loop.rb","rh_puts_ac.rb","rain.rb","ma_puts_ac.rb","cputemp_loop.rb",
      "circulator.rb","fan.rb","heater.rb","curtain.rb",
      "controller_window.rb","controller_window2.rb","controller_window3.rb",
      "illi1.rb","illi2.rb","illi3.rb","illi4.rb",
      "light.rb","light2.rb","light3.rb","light4.rb","light5.rb",
      "co2.rb",
      "main_ma.rb"]
"numato_server.rb"
"server.rb"
ls.each do |filename|
  p filename
  unless str.include?(filename)
    exec_rb(filename,sleep_sec=0,dir="./",test=true)
  end
end

=begin
unless str.include?("numato_server.rb")
  #p "t"
  log("log.txt",ls[0])
#  system("cat ./mch.txt >> ./error_mch.txt")
#  system("lxterminal -e /home/pi/.rvm/bin/ruby ./#{ls[0]}") 
#  sleep 20 #Wait TupleSpace initialize
end

unless str.include?(ls[1])
  #p "s"
  log("log.txt",ls[1])
#  system("lxterminal -e /home/pi/.rvm/bin/ruby ./#{ls[1]}")
end

unless str.include?(ls[2])
  #p "s4"
  log("log.txt",ls[2])
#  system("lxterminal -e /home/pi/.rvm/bin/ruby ./#{ls[2]}")
end
=end
