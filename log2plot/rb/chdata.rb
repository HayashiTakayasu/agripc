require "date"
#require "pp"
def ary2dat(res)
  str=""
  res.each do |ary|
    ary.each do |dat|
      str=str+dat.to_s+","
    end
    str=str.chop+"\n"
  end
  str
end
def chdat(file,list,time_format="%Y-%m-%d %H:%M:%S")
  str = File.read(file)

  res=[]
  str.each_line do |line|
    dat=line.chomp.split(",")
    i=0
    kekka=[]
    dat.each do |datum|
      list[i]
      datum
      if (list[i]!=false) and (list[i]!="time")
        list[i].to_f
        datum.to_f
        kekka << list[i].to_f*datum.to_f
      elsif (list[i]=="time")
        kekka << DateTime.parse(datum).strftime(time_format)
      else
        kekka << datum
      end
      i+=1
      
    end
    res << kekka
  end
  res
  
  
end

if $0==__FILE__
  list=["time",1.0,1.0/3,1.0,false,1.0,false,1.0,false]
  file= ARGV[0] || "thermo.csv"
  ls=eval(ARGV[1].to_s) || list
  
  str=chdat(file,list)
  print ary2dat(str)
  
end
