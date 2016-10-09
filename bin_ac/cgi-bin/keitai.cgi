#!ruby -Ku
#coding:utf-8
require "redis"
db=Redis.new
h=db.get("usbrh3:housa")
if h!="0" 
  sensors=%Q|<td>センサー3(usbrh1)</td><td>#{db.get("usbrh1:degree")}℃</td><td>#{db.get("usbrh1:humidity")}%</td><td></td><td>#{db.get("usbrh1:housa")}</td><tr/>
<td>センサー4(usbrh2)</td><td>#{db.get("usbrh2:degree")}℃</td><td>#{db.get("usbrh2:humidity")}%</td><td></td><td>#{db.get("usbrh2:housa")}</td><tr/>
<td>センサー5(usbrh3)</td><td>#{db.get("usbrh3:degree")}℃</td><td>#{db.get("usbrh3:humidity")}%</td><td></td><td>#{h}</td><tr/>|
end

print "Content-Type: text/html\n\n"
print <<EOS 
  <html>
    <head>
      <title>keitai.cgi</title>
    </head>
    <body>
センサー状況
<table border="1">
<td>番号</td><td>温度℃</td><td>湿度%</td><td>CO2濃度ppm</td><td>飽差g/m3</td><tr/>

<td>センサー1</td><td>#{db.get("usbrh:degree")}℃</td><td>#{db.get("usbrh:humidity")}%</td><td></td><td>#{db.get("housa")}</td><tr/>
<td>センサー2</td><td>#{db.get("degree")}℃</td><td></td><td>#{db.get("ppm")}</td><td></td><tr/>
#{sensors}
<td>雨センサー</td><td>#{if db.get("rain")=="1";"ON";else "OFF";end }</td><td></td><td></td><td></td>
<tr/>
</table>
    <a href="./main.cgi">mainメインへ</a>
EOS
print "</body></html>"
