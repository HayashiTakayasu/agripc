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

table=""
24.times do |i|
table+= <<eos
<td> #{i.to_s}:<select name="sec#{i.to_s}" size=1>
  <option value="00" selected>00</option>
  <option value="15">  15</option>
  <option value="30">  30</option>
  <option value="45">  45</option></dselect>
</td>
<td><select name="ppm#{i}" size=1>
  <option value="" selected></option>
  <option value="0">  0ppm</option>  
  <option value="300">  300ppm</option>
  <option value="350">  350ppm</option>
  <option value="380">  380ppm</option>
  <option value="400">  400ppm</option>
  <option value="500">  500ppm</option>
  <option value="600">  600ppm</option>
  <option value="700">  700ppm</option>
  <option value="800">  800ppm</option>
  <option value="900">  900ppm</option>
  <option value="1000">1000ppm</option>
  <option value="1100">1100ppm</option>
  <option value="1200">1200ppm</option>
  <option value="1300">1300ppm</option>
  <option value="1400">1400ppm</option>
  <option value="1500">1500ppm</option>
  <option value="1800">1800ppm</option>
  <option value="2000">2000ppm</option>
</select></td><tr/>

eos
end
print "Content-Type: text/html

"

print <<eos

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>co2-2.cgi</title>
      </head>
      <body>
<h1>./config/co2を設定(2)</h1>
現在の値：#{yml_value}

<form action="./post_sample.cgi" method="post">
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
<table border="1">
<td>設定項目</td><td>設定</td><tr/>

#{table}

</table>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
</form>
<img src="../co2.png" alt="../co2.png">
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos
