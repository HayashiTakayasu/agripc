#!ruby -Ku
#coding:utf-8
require "cgi"
require "./web"
require "./setting_io"
#url=Setting_io::yaml_load("url.yml")
include AgriController
#if RUBY_VERSION >= '1.9'
#yml_file=Dir.glob("./config/*".encode("sjis")).sort
#else
yml_file=Dir.glob("./config/*").sort
#end

ret="<table border='1'>"

yml_file.each do |file|
  if File.file?(file)
    x=File.basename(file)
    ret=ret+"<td><a href=./#{x}.cgi>#{x}</a></td><td>#{
    #p file
    begin
      yaml_dbr(x,file).inspect
    rescue
      #p "text"
      File.read(file)
    end
    }</td><tr/>\n"
  end
end
ret+="</table>"

print "Content-Type: text/html\n\n"
print Web::html_head("setting.cgi")
#[ポート番号,子機台数]
#[設定秒数(弁１),設定秒数(弁２)],[時刻(ex."12:00:00"),"12:30"]．．．]
str= <<eos
<h1>設定</h1>
#{ret}
eos

print str

print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./reset_.cgi">設定初期化</a>
eos

print "</body></html>"
