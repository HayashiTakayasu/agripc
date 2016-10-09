require "rubygems"
require "agri-controller"
include AgriController
loop do 
  p data=`ruby ./cputemp.rb`.chomp
  Loger::loger("./thermo_data/cputemp.txt",data)
  sleep 600
end