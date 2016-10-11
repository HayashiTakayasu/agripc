require "date"

str=File.dirname($0)
`touch user_name.txt`
name=File.read("user_name.txt").chomp
Dir.chdir(str+"/bin_ac/htdocs")
#p Dir.glob("*")
p Dir.pwd
#day=Date.today.to_s
#p command="zip -rq ./data/data_#{name}.zip thermo log"
p command="tar zcfh ./data/data_#{name}.tar.gz thermo log"
`#{command}` unless $DEBUG

