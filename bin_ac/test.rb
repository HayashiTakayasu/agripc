#ruby -Ku
#coding:utf-8
#$:.unshift("../lib") if $0==__FILE__
p $0
p dir=Dir.pwd
p File.dirname(dir)
p root=File.dirname($0)
p Dir.chdir root
p Dir.pwd
sleep 3
=begin
require "rubygems"
require "agri-controller"
include AgriController

Thread.abort_on_exception=true

#Save program-ID
p pid=Process.pid
open("main_pid","w"){|io| io.print pid.to_s}

#Set File.dirname(dir)TRAP
trap(:KILL){Process.kill(:QUIT, Process.pid)}

#config setting
dircopy

#Run
a=Thread.start{thermo_gruff_loop}
#main loop
load "main_linux.rb"
kr_run
a.join
=end
