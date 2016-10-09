#!ruby -Ku
#coding:utf-8
require "cgi"
require "./web"
require "./setting_io"
include AgriController
#url=yaml_load("url.yml")
print "Content-Type: text/html\n\n"
print Web::html_head("reset.cgi")
#[ポート番号,子機台数]
#[設定秒数(弁１),設定秒数(弁２)],[時刻(ex."12:00:00"),"12:30"]．．．]
yaml_dump(true,"reload_flag.yml")

str= <<eos
<h1>リセット</h1>
eos

print str
print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>
<a href="./setting.cgi">設定変更(setting)</a>
eos
print "</body></html>"
