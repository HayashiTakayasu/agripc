require "date"

#initialize
define_name=ARGV[0] || "" 
day=Date.today.to_s
pwd=Dir.pwd
name=["agripc","ma"]
name.each do |dir|
  print "backup : "+dir
  begin  #cp messages
    Dir.chdir(dir+"/messages")
    puts ""  
    `rm -rf messages*`
    p "ruby ./cp_mes.rb"
    `ruby ./cp_mes.rb`
    Dir.chdir(pwd)
    p Dir.pwd

    #ac backup
    filename=dir+day+define_name+".tar.gz"
    p command="tar -zcf #{filename} #{dir} --exclude ./agripc/bin_ac/htdocs/data ./agripc/dblog.txt"
    `#{command}`
  rescue =>ex
    print "  # =>error!! \n"
  #  p ex
  end
end
