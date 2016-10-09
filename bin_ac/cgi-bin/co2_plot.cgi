#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
require "time"
include AgriController

yml=yaml_dbr("house3","./config/house3")
yml_value=yml.inspect
##
#
list=[["0:00",yml.last[1]]]
yml.each{|ls| list <<[ls[0],ls[1]]}
list<< ["23:59",yml.last[1]]
#
open("co2.txt","w"){|io| 
  list.each do |ls|
    io.print ls[0]+","+ls[1].to_s+"\n" 
  end
}
begin
`gnuplot ./sample.plot`
rescue
end

print "Content-Type: text/html

"

print <<eos

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>house1.cgi</title>
      </head>
      <body>
<h3><a href="./co2-2.cgi">co2濃度を設定変更(setting)</a></h3>
<img src="../co2.png" alt="../co2.png">
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>


</body></html>
eos
