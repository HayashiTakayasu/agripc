#ruby -Ku
#coding:utf-8
#$:.unshift("../lib") if $0==__FILE__
require "rubygems"
require "agri-controller"
include AgriController
thermo_gruff_loop(verbose=false,dir_to="./htdocs/thermo",dir_from="./cgi-bin/log",num=4,size1="480x340",size2="220x250")

