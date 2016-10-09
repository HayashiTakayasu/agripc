#!ruby
target="pi@192.168.11.200"
dir=File.dirname(__FILE__)
Dir.chdir(dir)
if $DEBUG==true
  flag="-d"
else
  flag=""
end
command="ruby #{flag} ./time_adjust_local.rb "+target

loop do
  #p command
  unless $DEBUG 
    print `#{command}`
    sleep 36000
  else
    print `#{command}`
    break
  end
end
