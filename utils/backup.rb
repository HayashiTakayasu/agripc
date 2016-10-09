require "date"

#initialize
define_name=ARGV[0] || "toriuchi" 
day=Date.today.to_s
pwd=Dir.pwd
dir="ma"
#cp messages
Dir.chdir(dir+"/messages")
`rm -rf messages*`
p "ruby ./cp_mes.rb"
`ruby ./cp_mes.rb`
Dir.chdir(pwd)
p Dir.pwd

#ac backup
filename=dir+day+define_name+".tar.gz"
p command="tar -zcf #{filename} #{dir}"
`#{command}`

=begin
#cam1 backup
Dir.chdir("./www/htdocs")
p Dir.pwd
filename="cam1-"+day+define_name+".tar.gz"
p "tar -czvf #{pwd}/#{filename} cam1"
`tar -czvf #{pwd}/#{filename} cam1`
`rm -rf cam1/*`
Dir.chdir("../../")

=end
