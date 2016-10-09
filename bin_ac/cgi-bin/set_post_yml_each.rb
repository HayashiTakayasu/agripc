#!ruby -Ku
#coding:utf-8
require "cgi"
require "./web"
require "./setting_io"
include AgriController

yml_file=Dir.glob("./config/*.yml")

ret=""
hash={}
yml_file.each do |file|
#basename
x=File.basename(file)
p x+"  : "+file
#link
str= <<eos
<a href="./#{x}.cgi">#{x}</a><br/>
eos

io=open("post_#{x}.cgi","w"){|io|
io.print <<eos
#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

# $SAFE=1
cgi=CGI.new
text1=cgi["text1"]

yaml_db("#{x}",eval(text1),"./config/#{x}")
yml=yaml_dbr("#{x}","./config/#{x}")
yml_value=yml.inspect
yaml_db("reload_flag",true,"./config/reload_flag")
eos

io.print <<EOS
print "Content-Type: text/html\n\n"
\nprint <<EOS\n
EOS

io.print Web::html_head("post_#{x}.cgi")
str1= <<eos
EOS
print "<h1>#{file}セット完了</h1>
動作確認を願います<br/>\n"
eos
str2= <<eos
eos

str3= <<eos
eos
io.print(str1)
io.print("print yml_value\n")
io.print <<eos
print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

eos
io.print "</body></html>"
#
io.print "\neos"
}

end
