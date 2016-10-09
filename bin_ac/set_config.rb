#x="./cgi-bin/log/"
#p File.exist?(x)
require "rubygems"
require "agri-controller"
include AgriController
#require "pp"
list=Dir.glob("cgi-bin/config/*").sort
#if $ARGV ==nil
catch(:exit) do
  loop do
    x=0
    hash={}
    
    list.each do |file|
      #print x.to_s," : ",File.read(file),"\n"
      if File.file?(file)
        base=File.basename(file)
        y=yaml_dbr(base,file)
        print x.to_s,":",base,":    ",y.inspect,"\n"
        #config object to Hash
        hash[x.to_s]=[file,y]
        x+=1
      end
    end
    
    print "<0-#{x-1}>input_number:"
    a=gets().chomp.upcase
    if hash.has_key?(a)
      y2=hash[a]
      print y2[0].inspect," # => ",y2[1].inspect,"\nnew_data:"
      x=gets.chomp
      if x!=""
        begin
          p yaml_db(File.basename(y2[0]),eval(x),y2[0])
        rescue
          p yaml_dbr(File.basename(y2[0]),y2[0])
        end
        sleep 0.3
      end
    elsif a.include?("E") or a.include?("Q") or a.include?("B")
      throw :exit
    else
    end
    a="",x=""
  end
end
print "bye!\n"
