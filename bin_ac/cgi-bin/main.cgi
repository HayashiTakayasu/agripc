#!ruby #-Ku
#coding:utf-8
require "./setting_io"
require "cgi"
require "./bit"
require "./housa" 
require 'redis'
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

error=""
begin
  error=File.read("./log/errors.txt")
rescue
  #none
end

bgcolor=""
if error!=""
  bgcolor=' bgcolor="pink"'#"#ff7777"'
elsif rain=="1"
  bgcolor=' bgcolor="ccffff"'
end

light=`python ./sun_.py`

print "Content-Type: text/html\n\n"


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

illi_sub=""
light_sub=""
h3="0"

str= <<eos
<h4>時刻：#{Time.now}　<a href="./time_adjust.cgi">時刻の変更をする</a><br/>#{tenki}   雨センサ：#{rain_sensor}</h4>

<a href="./thermo_graph.cgi">昨日と今日の温湿度グラフ(graph)</a>　　<!-- a href="./keitai.cgi">携帯で温度確認する、サンプル画面</a --><br/>
<h2><a href="../">top</a>　　　<a href="../main">携帯用画面</a>　　　<a href="http://192.168.11.200:10080/main">センサー側の状況・停止等</a>
　　<a href="../data">バックアップデータ</a>　</h2>
<hr/>
センサー状況
<table border="1">
<td>番号</td><td>温度℃</td><td>湿度%</td><td>CO2濃度ppm</td><td>飽差g/m3</td><td>露点℃</td><td>絶対湿度g/m3</td><tr/>
<td>センサー1</td><td>#{db.get("degree")}℃</td><td>#{db.get("humidity")}%</td><td>#{db.get("ppm")}ppm</td><td>#{db.get("housa")}</td><td>#{db.get("roten")}</td><td>#{db.get("zettai")}</td><tr/>
<td>地温</td><td>#{db.get("soil_temp")}℃</td><td></td><td></td><td></td><td></td><td></td><tr/>
</table>
 
<hr/>
<img src="../thermo/thermo_data.csv.png" alt="thermo/thermo_data.csv.png" width="100%" height="100%"/><br/>

<hr/>

eos

print str

name=["window0","window1","window2","window3","window4","window5","window6","window7"
]
name2=["co2","co2_2","heater","heater_2","fan","fan_2","circulator","circulator_2","boiler"
]
name3=["curtain0_open","curtain0_close","curtain1_open","curtain1_close","light","light_2"]

def namer(n)
yaml_dbr("a","./config/#{n}_").to_s
end

print <<eos
<h1>設定変更</h1>
<h3>　　手動にする所をチェックし、on・offを指示し、送信を押してください。<br/>
　　自動設定の項目を変更してください
</h3><hr/>
<p>多段サーモ(巻き上げ、暖房、炭酸ガス、換気扇など)は、

<pre><span class="code" style="border:0px solid #555;background-color:#EEEEEE;color:#000000">[　["1:00",25],["時刻(半角)",数値(半角)],["22:00",28]　]
</span><hr/>
循環扇、カーテンは、
<span class="code" style="border:0px solid #555;background-color:#EEEEEE;color:#000000">[　["6:30:05",300],["時刻",秒数],["22:00",600]　]
</span><hr/>
電照は、
<span class="code" style="border:0px solid #555;background-color:#EEEEEE;color:#000000">[　["0:00","1:00"],["点灯時刻","消灯時刻"],["18:00","20:00"],["23:00","23:59:59"]　]
</span>
など。日付をまたぐ場合は、上記のようにすると、２３：００～１：００まで点灯します。

</pre>
<h4>ルール</h4>
  <li>鍵カッコ、や、"などは、厳密に書かないと動きません。
　<li>数字、：などもすべて半角文字です。
　<li>時刻は、左から順に並べること
</p>
<br/><hr/>
<form method="get" action="post_manual.cgi">
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>

<table border="1">
<td><b><a href="./main_setting.cgi">名称(変更はクリック)</a></b></td><td>手動にする</td><td>オン・オフ</td><td>自動設定</td><tr/>

<td><b>#{namer(name[0])}</b></td><td><label><input type="checkbox" name="config_0" value="1">bit 0</label></td>
<td><label><input type="checkbox" name="manual_0" value="1"></label>巻上１　開く</td><td><a href="./#{name[0]}.cgi">#{yaml_dbr(name[0],"./config/#{name[0]}").to_s}</a></td><tr/>

<td></td><td><label><input type="checkbox" name="config_1" value="1">bit 1</label></td>
<td><label><input type="checkbox" name="manual_1" value="1"></label>巻上１　閉める</td><td></td><tr/>
<tr bgcolor="#ffffc0">
<td><b>#{namer(name[1])}</b></td><td><label><input type="checkbox" name="config_2" value="1">bit 2</label></td>
<td><label><input type="checkbox" name="manual_2" value="1"></label>巻上２　開く</td><td><a href="./#{name[1]}.cgi">#{yaml_dbr(name[1],"./config/#{name[1]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td></td><td><label><input type="checkbox" name="config_3" value="1">bit 3</label></td>
<td><label><input type="checkbox" name="manual_3" value="1"></label>巻上２　閉める</td><td></td></tr>

<td><b>#{namer(name[2])}</b></td>
<td><label><input type="checkbox" name="config_4" value="1">bit 4</label></td>
<td><label><input type="checkbox" name="manual_4" value="1"></label>巻上３　開く　（雨センサーなし）</td><td><a href="./#{name[2]}.cgi">#{yaml_dbr(name[2],"./config/#{name[2]}").to_s}</a></td><tr/>

<td></td><td><label><input type="checkbox" name="config_5" value="1">bit 5</label></td>
<td><label><input type="checkbox" name="manual_5" value="1"></label>巻上３　閉める（雨センサーなし）</td><td></td><tr/>

<tr bgcolor="#ffffc0">
<td><b>#{namer(name[3])}</b></td>
<td><label><input type="checkbox" name="config_6" value="1">bit 6</label></td>
<td><label><input type="checkbox" name="manual_6" value="1"></label>巻上４　開く　（雨センサーなし）</td><td><a href="./#{name[3]}.cgi">#{yaml_dbr(name[3],"./config/#{name[3]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td></td><td><label><input type="checkbox" name="config_7" value="1">bit 7</label></td>
<td><label><input type="checkbox" name="manual_7" value="1"></label>巻上４　閉める（雨センサーなし）</td><td></td></tr>

<td><b>#{namer(name[4])}</b></td>
<td><label><input type="checkbox" name="config_8" value="1">bit 8</label></td>
<td><label><input type="checkbox" name="manual_8" value="1"></label>巻上５　開く</td><td><a href="./#{name[4]}.cgi">#{yaml_dbr(name[4],"./config/#{name[4]}").to_s}</a></td><tr/>

<td></td><td><label><input type="checkbox" name="config_9" value="1">bit 9</label></td>
<td><label><input type="checkbox" name="manual_9" value="1"></label>巻上５　閉める</td><td></td><tr/>
<tr bgcolor="#ffffc0">
<td><b>#{namer(name[5])}</b></td>
<td><label><input type="checkbox" name="config_A" value="1">bit A</label></td>
<td><label><input type="checkbox" name="manual_A" value="1"></label>巻上６　開く</td><td><a href="./#{name[5]}.cgi">#{yaml_dbr(name[5],"./config/#{name[5]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td></td><td><label><input type="checkbox" name="config_B" value="1">bit B</label></td>
<td><label><input type="checkbox" name="manual_B" value="1"></label>巻上６　閉める</td><td></td></tr>

<td><b>#{namer(name[6])}</b></td>
<td><label><input type="checkbox" name="config_C" value="1">bit C</label></td>
<td><label><input type="checkbox" name="manual_C" value="1"></label>巻上７　開く　（雨センサーなし）</td><td><a href="./#{name[6]}.cgi">#{yaml_dbr(name[6],"./config/#{name[6]}").to_s}</a></td><tr/>

<td></td><td><label><input type="checkbox" name="config_D" value="1">bit D</label></td>
<td><label><input type="checkbox" name="manual_D" value="1"></label>巻上７　閉める（雨センサーなし）</td><td></td><tr/>
<tr bgcolor="#ffffc0">
<td><b>#{namer(name[7])}</b></td>
<td><label><input type="checkbox" name="config_E" value="1">bit E</label></td>
<td><label><input type="checkbox" name="manual_E" value="1"></label>巻上８　開く　（雨センサーなし）</td><td><a href="./#{name[7]}.cgi">#{yaml_dbr(name[7],"./config/#{name[7]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td></td><td><label><input type="checkbox" name="config_F" value="1">bit F</label></td>
<td><label><input type="checkbox" name="manual_F" value="1"></label>巻上８　閉める（雨センサーなし）</td><td></td></tr>

#{%!
<td>#{namer(name2[0])}</td>
<td><label><input type="checkbox" name="config_G" value="1">bit G</label></td>
<td><label><input type="checkbox" name="manual_G" value="1"></label>ＣＯ２機器１</td><td><a href="./#{name2[0]}.cgi">#{yaml_dbr(name2[0],"./config/#{name2[0]}").to_s}</a></td><tr/>
! if namer(name2[0])!=""}

#{%!
<td>#{namer(name2[1])}</td>
<td><label><input type="checkbox" name="config_H" value="1">bit H</label></td>
<td><label><input type="checkbox" name="manual_H" value="1"></label>ＣＯ２機器２</td><td><a href="./#{name2[1]}.cgi">#{yaml_dbr(name2[1],"./config/#{name2[1]}").to_s}</a></td><tr/>
! if namer(name2[1])!=""}

#{%!<tr bgcolor="pink">
<td>#{namer(name2[2])}</td><td><label>
<input type="checkbox" name="config_I" value="1">bit I</label></td>
<td><label><input type="checkbox" name="manual_I" value="1"></label>暖房機１</td><td><a href="./#{name2[2]}.cgi">#{yaml_dbr(name2[2],"./config/#{name2[2]}").to_s}</a></td></tr>! if namer(name2[2])!=""}


#{%!<tr bgcolor="pink"><td>#{namer(name2[3])}</td>
<td><label><input type="checkbox" name="config_J" value="1">bit J</label></td>
<td><label><input type="checkbox" name="manual_J" value="1"></label>暖房機２</td><td><a href="./#{name2[3]}.cgi">#{yaml_dbr(name2[3],"./config/#{name2[3]}").to_s}</a></td></tr>! if namer(name2[3])!=""}

#{%!
<tr bgcolor="#bbbbff"><td>#{namer(name2[4])}</td>
<td><label><input type="checkbox" name="config_K" value="1">bit K</label></td>
<td><label><input type="checkbox" name="manual_K" value="1"></label>換気扇１</td><td><a href="./#{name2[4]}.cgi">#{yaml_dbr(name2[4],"./config/#{name2[4]}").to_s}</a></td></tr>
! if namer(name2[4])!=""}

#{%!
<tr bgcolor="#bbbbff"><td>#{namer(name2[5])}</td>
<td><label><input type="checkbox" name="config_L" value="1">bit L</label></td>
<td><label><input type="checkbox" name="manual_L" value="1"></label>換気扇２</td><td><a href="./#{name2[5]}.cgi">#{yaml_dbr(name2[5],"./config/#{name2[5]}").to_s}</a></td></tr>
! if namer(name2[5])!=""}

#{%!
<td>#{namer(name2[6])}</td>
<td><label><input type="checkbox" name="config_M" value="1">bit M</label></td>
<td><label><input type="checkbox" name="manual_M" value="1"></label>　循環扇１</td><td><a href="./#{name2[6]}.cgi">#{yaml_dbr(name2[6],"./config/#{name2[6]}").to_s}</a></td><tr/>
! if namer(name2[6])!=""}

#{%!
<td>#{namer(name2[7])}</td>
<td><label><input type="checkbox" name="config_N" value="1">bit N</label></td>
<td><label><input type="checkbox" name="manual_N" value="1"></label>　循環扇２</td><td><a href="./#{name2[7]}.cgi">#{yaml_dbr(name2[7],"./config/#{name2[7]}").to_s}</a></td><tr/>
! if namer(name2[7])!=""}

#{%!
<tr bgcolor="pink"><td>#{namer(name2[8])}</td>
<td><label><input type="checkbox" name="config_O" value="1">bit Ｏ</label></td>
<td><label><input type="checkbox" name="manual_O" value="1"></label>温湯ボイラ</td><td><a href="./#{name2[8]}.cgi">#{yaml_dbr(name2[8],"./config/#{name2[8]}").to_s}</a></td></tr>
! if namer(name2[8])!=""}

#{%!
<td>#{namer(name3[0])}</td><td><label><input type="checkbox" name="config_P" value="1">bit P</label></td>
<td><label><input type="checkbox" name="manual_P" value="1"></label>カーテン１　開く</td><td><a href="./#{name3[0]}.cgi">#{yaml_dbr(name3[0],"./config/#{name3[0]}").to_s}</a></td><tr/>

<td>#{namer(name3[1])}</td><td><label><input type="checkbox" name="config_Q" value="1">bit Q</label></td>
<td><label><input type="checkbox" name="manual_Q" value="1"></label>カーテン１　閉じる</td><td><a href="./#{name3[1]}.cgi">#{yaml_dbr(name3[1],"./config/#{name3[1]}").to_s}</a></td><tr/>
! if namer(name3[0])!=""}

#{%!
<tr bgcolor="#ffffc0"><td>#{namer(name3[2])}</td>
<td><label><input type="checkbox" name="config_R" value="1">bit R</label></td>
<td><label><input type="checkbox" name="manual_R" value="1"></label>カーテン２　開く</td><td><a href="./#{name3[2]}.cgi">#{yaml_dbr(name3[2],"./config/#{name3[2]}").to_s}</a></td></tr>
! if namer(name3[2])!=""}

#{%!
<tr bgcolor="#ffffc0">
<td>#{namer(name3[3])}</td><td><label><input type="checkbox" name="config_S" value="1">bit S</label></td>
<td><label><input type="checkbox" name="manual_S" value="1"></label>カーテン２　閉じる</td><td><a href="./#{name3[3]}.cgi">#{yaml_dbr(name3[3],"./config/#{name3[3]}").to_s}</a></td></tr>
! if namer(name3[3])!=""}

#{%!
<tr bgcolor="#ffffc0"><td>#{namer(name3[4])}</td>
<td><label><input type="checkbox" name="config_T" value="1">bit T</label></td>
<td><label><input type="checkbox" name="manual_T" value="1"></label>電照１</td><td><a href="./#{name3[4]}.cgi">#{yaml_dbr(name3[4],"./config/#{name3[4]}").to_s}</a></td></tr>
! if namer(name3[4])!=""}

#{%!
<tr bgcolor="#ffffc0"><td>#{namer(name3[5])}</td>
<td><label><input type="checkbox" name="config_U" value="1">bit U</label></td>
<td><label><input type="checkbox" name="manual_U" value="1"></label>電照２</td><td><a href="./#{name3[5]}.cgi">#{yaml_dbr(name3[5],"./config/#{name3[5]}").to_s}</a></td></tr>
! if namer(name3[5])!=""}

#{%!
<td>#{namer(name3[6])}</td>
<td><label><input type="checkbox" name="config_V" value="1">bit V</label></td>
<td><label><input type="checkbox" name="manual_V" value="1"></label></td><td></td><tr/><tr/>
! if namer(name3[6])!=""}
<table border="1">

     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>

<!--<a href="./manual.cgi">手動設定</a><br/>-->

"#{db.get("numato_bit")}":last_bit<br/>
#{m1.tos(32,2).inspect}:manual_flag<br/>
#{m2.tos(32,2).inspect}:manual_command<hr/>

<h4>電照時間の計算書<h4>
#{light}<br/><br/>
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

