require "date"

#initialize
p define_name=File.read("user_name.txt").chomp || "" 
day=Date.today.to_s
pwd=Dir.pwd
name=["agripc"] #,"ma"]
name.each do |dir|
  print "backup : "+dir
  begin  #cp messages
    Dir.chdir("messages")
    puts ""  
    `rm -rf messages*`
    p "ruby ./cp_mes.rb"
    `ruby ./cp_mes.rb`
    Dir.chdir(pwd)
    p Dir.pwd

    Dir.chdir("../")
    p Dir.pwd
    #ac backup
    filename="backup_#{define_name}.tar.gz"
    p command="tar -zcf #{filename} #{dir} --exclude #{dir}/bin_ac/htdocs/data"
    `#{command}` unless $DEBUG
    p command2=%Q!mv ./#{filename} #{pwd}/bin_ac/htdocs/data/! 
    `#{command2}` unless $DEBUG
  rescue =>ex
    print "  # =>error!! \n"
  #  p ex
  end
end
