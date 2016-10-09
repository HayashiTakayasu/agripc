require "redis"
db=Redis.new

32.times do |i|
 str=i.to_s(36).upcase
 p command="relay on #{str}"
 db.rpush(:numato,command)
end

32.times do |i|
 str=i.to_s(36).upcase
 p command="relay off #{str}"
 db.rpush(:numato,command)
end