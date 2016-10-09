#ruby -Ku
#coding:utf-8
#$:.unshift("../lib") if $0==__FILE__

#chroot dir
p root=File.dirname($0)
Dir.chdir root

require "rubygems"
require "gruff"
require "agri-controller"
require "agri-controller/gruff"

include AgriController

Thread.abort_on_exception=true

#Save program-ID
p pid=Process.pid
open("main_pid","w"){|io| io.print pid.to_s}

#Set TRAP
trap(:KILL){Process.kill(:QUIT, Process.pid)}

#config setting
#dircopy

#Run
#a=Thread.start{thermo_gruff_loop(true,"./htdocs/thermo","./cgi-bin/log",5,"480x420","220x250")}
#main loop
load "main2012.rb"
kr_run
a.join
