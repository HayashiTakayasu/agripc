#require "rubygems"
#require "serialport"

#samples=["\u0002P02EB3D\r\u0002B120C60\r\u0002n4E530F\r\n",
#         "\u0002n4E5915\r\u0002P02E83A\r\u0002B120B5F\r\n",
#         "\u0002n4E4C08\r\u0002P02F042\r\u0002B12075B\r",
#         "nonono!\rbadchar!",
#         nil]
#ppms=[747,744,752]

def check_sum(str)
  
end

def parse(str)
  begin
    res={}
    list=str.split("\r")
    list.each do |x|
      #p x
      #p x[1]
      if x[1]=="P" or x[1].chr=="P"
        a=x.slice(2,4).to_i(16)
        #p a
        #p a.class
        res["3"]=[a,"ppm"]
      end
      if x[1]=="B" or x[1].chr=="B"
        a=x.slice(2,4).to_i(16)
        #p a
        #p a.class
        
        res["2"]=[a/16.0-273.15,"Celsius Degree"] if a!=0
      end
    end
    res["1"]=[48,"humidity_DUMMY"]
    return nil if res.keys.size<=2 
  rescue
    nil
  end
  
  return res
end

if $0==__FILE__
  #i=0
  #samples.each do |str|
  #  res=parse(str)
  #  p ppms[i]==res
  #  i+=1
  #end
  a=File.read("ma.txt")
  puts parse(a)
end
