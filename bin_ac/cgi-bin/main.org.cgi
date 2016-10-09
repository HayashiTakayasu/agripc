#!ruby #-Ku
#coding:utf-8
require "./setting_io"
require "cgi"
require "./bit"
require "./housa" 
require "redis"
include AgriController

db=Redis.new
rain=db.get("rain")
if rain=="0"
  rain_sensor="OFF"
  tenki="天気は良さそうです"
else
  #rain="1"
    rain_sensor="ON"
  tenki="天気が悪いようです…"

end


begin
#url=Setting_io::yaml_load("url.yml")
#yaml_db("manual_bool01.txt",nil,"./config/manual_bool01.txt")#manual01_reset
#yaml_db("manual_bool02.txt",nil,"./config/manual_bool02.txt")#manual02_reset
m1=Bit.new
m2=Bit.new
m1.bit=yaml_dbr("manual_0.txt","./config/manual_0.txt").to_i
m2.bit=yaml_dbr("manual_1.txt","./config/manual_1.txt").to_i


run_check=yaml_dbr("run_check","./config/run_check")
thermo_time=yaml_dbr("last_thermo_time","./config/last_thermo_time")
thermo=yaml_dbr("last_thermo_data","./config/last_thermo_data") || [] 

illi=yaml_dbr("time_array","./config/time_array").inspect
wait_time=yaml_dbr("wait_time","./config/wait_time").inspect
illi2=yaml_dbr("time_array2","./config/time_array2").inspect
illi3=yaml_dbr("time_array3","./config/time_array3").inspect

house1=yaml_dbr("house1","./config/house1").inspect
house2=yaml_dbr("house2","./config/house2").inspect
house3=yaml_dbr("house3","./config/house3").inspect
house3_2=yaml_dbr("house3-2","./config/house3-2").inspect

house4=yaml_dbr("house4","./config/house4").inspect
house5=yaml_dbr("house5","./config/house5").inspect
house6=yaml_dbr("house6","./config/house6").inspect
house7=yaml_dbr("house7","./config/house7").inspect
house8=yaml_dbr("house8","./config/house8").inspect
house9=yaml_dbr("house9","./config/house9").inspect
house9_2=yaml_dbr("house9_2","./config/house9_2").inspect
house9_3=yaml_dbr("house9_3","./config/house9_3").inspect
house9_4=yaml_dbr("house9_4","./config/house9_4").inspect
house9_5=yaml_dbr("house9_5","./config/house9_5").inspect

house10=yaml_dbr("house10","./config/house10").inspect
house11=yaml_dbr("house11","./config/house11").inspect
house12=yaml_dbr("house12","./config/house12").inspect

step=yaml_dbr("change_step","./config/change_step")

str="";i=1
if thermo.size==3
  comm=["","西　","東　","地温","　外"]
elsif thermo.size==5
  comm=["","西　","中　","東　","地温","　外"]
else
  comm=["","1　","2　","3　","4　","5　"]
end
thermo.each do |list|
str=str+"<td>#{i.to_s}#{comm[i]}</td>
<td>#{list[0].to_s}</td>
<td>#{list[1].to_s}</td>
<td>#{list[2].to_s}</td>
<td>#{list[4].to_s}</td>
<tr/>
"
i+=1
end
rescue
str=[]
end
log_file="./config/last_bit.txt"
begin
  dat=File.read(log_file)
  x=dat.split(",")
  yn="<br/>\n"
  last_data=x[0]+","+x[1]+yn#+"house 1:"+x[2]+"℃,"+x[3]+"%"+yn+"house 2:"+x[4]+"℃"+yn+"other  :"+x[5]+","+x[6]
rescue
  last_data="read ERROR.May be file busy.try NEXT"
end

#{CGI.escapeHTML(File.read("last_bit.txt"))}

error=""
error=File.read("./log/errors.txt")
bgcolor=""
if error!=""
  bgcolor=' bgcolor="pink"'#"#ff7777"'
elsif rain=="1"
  bgcolor=' bgcolor="ccffff"'
end

light=`python ./sun_.py`

print "Content-Type: text/html\n\n"

%!<h2><a href="./co2.cgi">CO２設定サンプル画面（有償）</a>　　　<a href="./co2-2.cgi">co２設定サンプル画面２(有償)</a></h2>!
%!画面更新：#{Time.now},動作確認：#{run_check},温湿度：#{thermo_time}<br/>!
%!<td>換気優先（仮）</td><td>谷換気を優先</td><tr/>
<a href="./thermo_graph.cgi">昨日と今日の温湿度グラフ(graph)</a><br/>
<a href="./log.cgi">動作ログ(log)</a><br/>
<td><a href=./house8.cgi>温湯ボイラ</td><td>#{house8}</td><tr/>
step:#{step[1]}!

print <<EOS 
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <META HTTP-EQUIV="Refresh" CONTENT="600;URL=./main.cgi">

        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>main.cgi</title>
    </head>
    <body#{bgcolor}>
EOS
#ハウス３開閉：#{house3}　#{db.get("window3")}
sensors=""

h1=db.get("usbrh1:housa")
if h1!="0"
  sensors=sensors+%Q|<td>センサー3(usbrh1)</td><td>#{db.get("usbrh1:degree")}℃</td><td>#{db.get("usbrh1:humidity")}%</td><td></td><td>#{h1}</td><tr/>|
end

h2=db.get("usbrh2:housa")
if h2!="0"
  sensors=sensors+%Q|<td>センサー4(usbrh2)</td><td>#{db.get("usbrh2:degree")}℃</td><td>#{db.get("usbrh2:humidity")}%</td><td></td><td>#{h2}</td><tr/>|
end

illi_sub=""
light_sub=""
h3=db.get("usbrh3:housa")
if h3!="0"
  sensors=sensors+%Q|<td>センサー5(usbrh3)</td><td>#{db.get("usbrh3:degree")}℃</td><td>#{db.get("usbrh3:humidity")}%</td><td></td><td>#{h3}</td><tr/>|
end
if false #ymgc#h1+h2+h3=="000"
    light_sub=%Q|<td><a href=./house9_5.cgi>電照5</td><td>#{house9_5}</td><tr/>|  
    illi_sub=%Q|<td><a href=./time_array2.cgi>潅水設定(育苗　親)</a></td><td>#{illi2}</td><tr/>
<td><a href=./time_array3.cgi>潅水設定(育苗　子1)</a></td><td>#{illi3}</td><tr/>
<td><a href=../house3-2.cgi>潅水設定(育苗　子2)</td><td>#{house3_2}</td><tr/>|

end

str= <<eos
<h4>時刻：#{Time.now}　<a href="./time_adjust.cgi">時刻の変更をする</a><br/>#{tenki}   雨センサ：#{rain_sensor}</h4>

<a href="./thermo_graph.cgi">昨日と今日の温湿度グラフ(graph)</a>　　<a href="./keitai.cgi">携帯で温度確認する、サンプル画面</a><br/>
<a href="../thermo/co2.png">温度,CO2(graph)</a><br/>
<hr/>
センサー状況
<table border="1">
<td>番号</td><td>温度℃</td><td>湿度%</td><td>CO2濃度ppm</td><td>飽差g/m3</td><tr/>
<td>センサー1</td><td>#{db.get("degree")}℃</td><td>#{db.get("humidity")}%</td><td>#{db.get("ppm")}ppm</td><td>#{db.get("housa")}</td><tr/>
<td>地温</td><td>#{db.get("soil_temp")}℃</td><td></td><td></td><td></td><tr/>

#{sensors}
</table>
 
<hr/>
<img src="../thermo/thermo_data.csv.png" alt="thermo/thermo_data.csv.png" width="100%" height="100%"/><br/>

<hr/>
<h3>設定(変更の場合、項目を押してください)</h3>
潅水
<table border="1">
<td>設定項目</td><td>設定</td><tr/>
<td><a href=./time_array.cgi>潅水設定(本圃)</a></td><td>#{illi}</td><td><a href=./wait_time.cgi>次段待時間:#{wait_time}秒</a></td><tr/>
#{illi_sub}
</table><br/>

温度管理・CO2
<table border="1">
<td>設定項目</td><td>設定</td><tr/>
<td><a href=./house1.cgi>谷換気　西</td><td>#{house1}</td><tr/>
<td><a href=./house2.cgi>谷換気　東</td><td>#{house2}</td><tr/>
<td><a href=./house3.cgi>谷換気　東1</td><td>#{house3}</td><tr/>

<td><a href=./house4.cgi>CO2濃度</td><td>#{house4}</td><tr/>
<td><a href=./house5.cgi>　換気扇</td><td>#{house5}</td><tr/>
<td><a href=./house6.cgi>循環扇（CO２・暖房と連動）</td><td>#{house6}</td><tr/>
<td><a href=./house7.cgi>暖房</td><td>#{house7}</td><tr/>

</table>
<br/>
その他・タイマー設定
<table border="1">
<td>設定項目</td><td>設定</td><tr/>
<td><a href=./house9.cgi>電照1</td><td>#{house9}</td><tr/>
<td><a href=./house9_2.cgi>電照2</td><td>#{house9_2}</td><tr/>
<td><a href=./house9_3.cgi>電照3</td><td>#{house9_3}</td><tr/>
<td><a href=./house9_4.cgi>電照4</td><td>#{house9_4}</td><tr/>
#{light_sub}

<td><a href=./house11.cgi>カーテン(開時刻)</td><td>#{house11}</td><tr/>
</table>
<hr/>
電照時間の計算書
#{light}<br/><br/>
eos
#<a href="./manual.cgi">手動画面(manual_setting)</a><br/>
#"_dddddBdD_JFC__cEcWc3c2c1KKO_fVV"<br/>
print str
print <<eos
<a href="./manual.cgi">手動設定</a><br/>

"#{db.get("numato_bit")}":last_bit<br/>
#{m1.tos(32,2).inspect}:manual_flag<br/>
#{m2.tos(32,2).inspect}:manual_command<hr/>
eos

print "</body></html>"
#最終動作：#{last_data}<br/>
#ERRORS　<a href="./error_clear.cgi">エラー消去(Error_CLEAR)</a>　<a href="./error_log.cgi">エラー・警告(Error_log)</a><br/>
#<font color=red>
#<p>#{error.inspect}</p>
#</font>

#　|　<a href="../console.txt">動作状況</a>　｜　<a href="../server.txt">server</a>
#　　<a href="../table.htm">潅水グラフ</a>　　<a href="http://127.0.0.1:8081/">motion</a><br/>
#
#<a href="./set.cgi">設定変更(setting)</a><br/>

