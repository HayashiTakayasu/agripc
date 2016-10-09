module AgriController
module_function
  ##
  # ==Usage
  # requrie "./counter"
  # counter([filename],Fixnum)
  #
  ##  At first
  # counter("./foo") #=>File.read("./foo") #=>"0"(create or value(String))
  # counter("./foo",:reset) #=>same above "0"
  #
  # counter("./foo",300) #=>File.read("./foo") #=>"300"
  # counter("./foo")     #=>"300"
  ##  next
  # counter("./foo",100) #=>File.read("./foo") #=>"400"
  #
  ##  other
  # counter("./foo",:reset) #=>File.read("./foo") #=>"0"
  #
  def counter(file,fixnum=0)
    p fixnum.class if $DEBUG
    if File.exist?(file)
      if fixnum.class!=Symbol
        now=File.read(file).to_f
        p now if $DEBUG
        if fixnum !=0
          res=now+fixnum
          p res if $DEBUG
          open(file,"w"){|io| io.print res.to_s}
          return res
        else
          return now
        end
      elsif fixnum==:reset
        open(file,"w"){|io| io.print "0"}
        return 0
      else
        #none ERROR
        p [file,fixnum,fixnum.class]
      end
    else
      #make file
      if fixnum==:reset
        fixnum=0
      end
      open(file,"w"){|io| io.print fixnum.to_s}
      return fixnum
    end
  end
end
if $0==__FILE__
include AgriController
  p counter("./foo",100) #=>File.read("./foo") #=>"0"
  #p counter("./foo",:reset) #=>same above "0"
  p counter("./foo")  
  p counter("./foo",300) #=>File.read("./foo") #=>"300"
  
  ##  next
  p counter("./foo",100) #=>File.read("./foo") #=>"400"
  p counter("./foo")
  ##  other
  p counter("./foo",52.1)
  p counter("./foo",:reset) #=>File.read("./foo") #=>"0"
end
