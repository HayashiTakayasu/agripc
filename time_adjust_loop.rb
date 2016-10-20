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

target2="pi@192.168.11.201"
#dir=File.dirname(__FILE__)
#Dir.chdir(dir)
#if $DEBUG==true
#  flag="-d"
#else
#  flag=""
#end
command2="ruby #{flag} ./time_adjust_local.rb "+target2

loop do
  #p command
  unless $DEBUG 
    print `#{command}`
    print `#{command2}`
    sleep 36000
  else
    print `#{command}`
    print `#{command2}`
    break
  end
end
