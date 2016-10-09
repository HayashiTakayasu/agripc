Dir.chdir(File.dirname(__FILE__))
require "csv"
require "time"

require "rubygems"
require "agri-controller"

require "./rb/log_anaryze"
require "./chdata"

include AgriController
  def log_anaryze1(one_array)
    #p one_array
    res=[]
    n=one_array.size
    if n >= 2
      res[0]=Time.parse(one_array[0])
      res[1]=one_array[1].split(" ")
    end
    res
  end

file2="../thermo_data/thermo_data.csv.*"

files="../log/log.txt.*"

_to=  "./ma_log2plot"

list2=Dir.glob(file2)#many thermo files list [...]

Dir.mkdir(_to) unless File.exist?(_to)

#1:  log.txt.day => {CO2|FAN}.day on ../log directory
day_name=""
list2.sort.each do |file|
  #p file

  day_name=File.basename(file).split(".").last# day_name=>"20121204"
  log_file_name=files+day_name
  #"../log/log.txt.20130119"
  if File.exist?(log_file_name) && (day_name !="jpg")
    str=File.read(log_file_name)
    ary=to_array(str,",")#[["Sat Nov 10 06:32:10 +0900 2012", "Fan ON ", "set:20",[]]..]
    #logger commend delete!
    ary.delete_at(0)
    #log_anaryze1(ary[1])
    hash={}
    ary.each do |ar|
      res=log_anaryze1(ar)
      res.size
      if res.size>1
        #p res[1][0]
        if hash.key?(res[1][0])
          hash[res[1][0]]<<[res[0],res[1][1]]
        else
          hash[res[1][0]]=[[res[0],res[1][1]]]
        end
      end
    end
    ##check hash
    hash.delete("start")
    hash.delete("action") 
    hash.delete("temp")
    #p hash.keys
    
    #p hash["CO2"]
    #p hash["Fan"]
    #p hash["heater"]
    today=hash["CO2"][0][0]
    tomorrow=today+24*60*60
    today=today.strftime("%Y-%m-%d")
    tomorrow=tomorrow.strftime("%Y-%m-%d")
    
    #save hash
    file_list=[]
    i=3 #Bit y_axis offset
    hash.keys.each do |key|
      csv_name=File.dirname(files)+"/#{key.to_s}.#{day_name}"
      
      unless File.exist?(csv_name)
        CSV.open(csv_name,"w") do |csv|
           hash[key].each do |ar|
             #p ar[1]
             if ar[1]=="ON"
              csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),i+0.7]
             elsif ar[1]=="OFF"
              csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),i+0]
            end
          end
        end
        file_list << csv_name
        i+=1
      end
    end
    
    #CSV.open(_to+"/"+"Fan_#{today}","w") do |csv|
    #  hash["Fan"].each do |ar|
    #    if ar[1]=="ON"
    #      csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),1.7]
    #    elsif ar[1]=="OFF"
    #      csv << [ar[0].strftime("%Y-%m-%d %H:%M:%S"),1]
    #    end
    #  end
    #end
    
    #thermo_data scale change(if need) && Day Format.
    list=["time",1.0,1.0,1.0]  
    str      =chdat(file,list,"%Y-%m-%d %H:%M:%S")

    p save_file=file+".format"
    open(save_file,"w"){|io| io.print ary2dat(str)} unless File.exist?(save_file)
    
    name=File.basename(save_file)
    
    #set gnuplot::plot script
    str=<<"EOS"
plot "#{name}" using 1:2 with lines title "Degree Celsius",\\
     "#{name}" using 1:($3/3e+0) with lines title "%  (1/  3)",\\
     "#{name}" using 1:($4/1e+2) with lines title "ppm(1/100)",\\
EOS
    hash.keys.sort.each do |key|
    bit_file_name=File.dirname(files)+"/#{key.to_s}.#{day_name}"
     str+=<<"EOS"
"#{bit_file_name}" using 1:2 with steps title " #{key.to_s} Bit",\\
EOS
    end
    str=str.chop.chop.chop
    
    #save .plot
    a=make_gnuplot(save_file+".plot.png",today,tomorrow,str,
                   format = 'set format x "%H:%M"',ytics = '')
    
    p file=save_file+".plot"
    open(file,"w"){|io| io.print a}
    #chdir and back origin.
    pwd=Dir.pwd
    Dir.chdir(File.dirname(file2))
      #plot finaly!
      p "gnuplot #{File.basename(file)}"
      system("gnuplot #{File.basename(file)}")
    Dir.chdir(pwd)
    
  end
  #rescue =>error
  #  p error
  #  next
  #end
end


  

p "end"
