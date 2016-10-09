#!ruby -Ku
#coding:utf-8
require "./web"
require "date"
#require "thermo_gruff"
require "./setting_io"
include AgriController

illi=yaml_dbr("time_array","./config/time_array").inspect
house1=yaml_dbr("house1","./config/house1").inspect
house2=yaml_dbr("house2","./config/house2").inspect

yesterday=(Date.today-1).to_s

print "Content-Type: text/html

"

print <<EOS 
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <META HTTP-EQUIV="Refresh" CONTENT="60;URL=./thermo_graph.cgi">

        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>昨日と今日のグラフthermo_graph.cgi</title>
    </head>
    <body>
EOS


#file="../thermo/"+yesterday+".jpg"
#if File.exist?("../htdocs/thermo/"+yesterday+".jpg")
#<img src="#{file}" alt="thermo/#{yesterday}.jpg"/>
print <<EOS
<img src="../thermo/thermo_data_yesterday.jpg" alt="thermo/thermo_data_yesterday.jpg" width="40%" height="70%"/>
EOS
#end

print <<EOS
<img src="../thermo/thermo_data.jpg" alt="thermo/thermo_data.jpg" width="40%" height="70%"/>
EOS

print <<EOS
<br/>潅水設定：#{illi},ハウス１開閉：#{house1},ハウス２開閉：#{house2}<br/>
EOS

print <<eos
<hr/>#{DateTime.now.to_s}
<a href="./main.cgi">メイン(main)</a>
<a href="./thermo_data_list.cgi">過去のデータ(thermo_data_list)</a>
</body></html>
eos
