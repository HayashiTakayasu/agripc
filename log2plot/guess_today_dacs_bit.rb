require "time"
def guess_today(file)
  time=nil
  
  str=File.read(file)
  str.each_line do |line|
    begin
      t=line.split(",")[1]
      time=Time.parse(t)
    rescue
      next
    end
    
    if time.class==Time
      break
    end
  end
  return time
end

if $0==__FILE__
  p guess_today(ARGV[0])
end
