#!ruby
dir=File.dirname(__FILE__)
Dir.chdir(dir)
#str="sudo date -s `ssh -i ../y2 agri@192.168.1.23 'date +%H:%M:%S'`"

ssh_address=ARGV[0] || "pi@192.168.111.100"

p date=`date +"%Y/%m/%d %H:%M:%S"`.chomp
puts t="ssh -i ./y2 #{ssh_address} \"sudo date -s '#{date}';sudo hwclock --systohc\""
#p str="sudo date -s '#{date}'"

system(t) unless $DEBUG
