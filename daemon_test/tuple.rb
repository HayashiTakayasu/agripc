Dir.chdir(File.dirname(__FILE__))

loop do
  system("/home/pi/.rvm/bin/ruby ./tuple_watch.rb")
  sleep 60
end
