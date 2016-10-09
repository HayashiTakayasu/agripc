#!ruby -Ku
#coding:utf-8
require "cgi"
require "./web"
require "./setting_io"
include AgriController
print "Content-Type: text/html\n\n"
print Web::html_head_refresh("./main.cgi",1)
#yaml_db("manual_bool01.txt",nil,"./config/manual_bool01.txt")
#yaml_db("kr01_readable.txt",nil,"./config/kr01_readable.txt")
yaml_db("reload_flag",true,"./config/reload_flag")

str= <<eos
<h1>自動画面へ</h1>手動は保持
eos

print str
print <<eos
<a href="./main.cgi">自動画面(main)</a><br/>
eos

print "</body></html>"
