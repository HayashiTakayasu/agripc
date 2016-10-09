#!ruby -Ku
#coding:utf-8
require "cgi"
require "./web"
require "./setting_io"
include Setting_io

yml_file=yaml_key
ret=""
hash={}
yml_file.each do |file|
#basename
p x=file
#link
str= <<eos
<a href="./#{x}.cgi">#{x}</a><br/>
eos

io=open("#{x}.cgi","w"){|io|
io.print <<eos
#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
yml=Setting_io::yaml_dbr("#{x}")
yml_value=yml.inspect
eos

io.print <<EOS
print "Content-Type: text/html\n\n"
\nprint <<eos\n
EOS

io.print Web::html_head("#{x}.cgi")
str1= <<eos
<h1>#{file}を設定</h1>
間違った変更をすると動作しません！
設定例：<br/>
eos
str2= <<eos
<br/>
  <form method="get" action="post_#{x}.cgi">
     <textarea type="text" name="text1" rows="5" cols="150" wrap="on">
eos

str3= <<eos
</textarea><br/>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
eos
io.print(str1+'#{yml_value}<br/>'+str2+'#{yml_value}'+str3)
io.print <<eos
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
