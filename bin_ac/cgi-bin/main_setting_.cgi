#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

print "Content-Type: text/html

"
name=["window0","window1","window2","window3","window4","window5","window6","window7"
]
name2=["co2","co2_2","heater","heater_2","fan","fan_2","circulator","circulator_2","boiler"
]
name3=["curtain0_open","curtain0_close","curtain1_open","curtain1_close","light","light_2"]
str= <<eos
<form action="./#{name[0]}_.cgi" method="get">
<input type="text" name="namae" value="#{yaml_dbr("a","./config/#{name[0]}_").to_s}" size="20" />
<input type="submit" name="submit" value="送信" /></form></td>
<td><label><input type="checkbox" name="config_0" value="1">bit 0</label>
eos

print <<eos
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>manual.cgi</title>
    </head>
    <body>
<h1>名称変更</h1>
  <form method="get" action="post_manual.cgi">
#manual Setting<br/>手動にする所をチェックし、on・offを指示してください。<br/>


<table border="1">
<td>名称</td><td>手動にする</td><td>オン・オフ</td><td>自動設定</td><tr/>

<td></td>
<td><label><input type="checkbox" name="manual_0" value="1"></label>巻上１　開く</td><td><a href="./#{name[0]}.cgi">#{yaml_dbr(name[0],"./config/#{name[0]}").to_s}</a></td><tr/>

<td></td>
<td><label><input type="checkbox" name="config_1" value="1">bit 1</label></td>
<td><label><input type="checkbox" name="manual_1" value="1"></label>巻上１　閉める</td><td></td><tr/>

<tr bgcolor="#ffffc0">
<td>名称</td>
<td><label><input type="checkbox" name="config_2" value="1">bit 2</label></td>
<td><label><input type="checkbox" name="manual_2" value="1"></label>巻上２　開く</td><td><a href="./#{name[1]}.cgi">#{yaml_dbr(name[1],"./config/#{name[1]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td></td>
<td><label><input type="checkbox" name="config_3" value="1">bit 3</label></td>
<td><label><input type="checkbox" name="manual_3" value="1"></label>巻上２　閉める</td><td></td></tr>

<td>名称<td>
<td><label><input type="checkbox" name="config_4" value="1">bit 4</label></td>
<td><label><input type="checkbox" name="manual_4" value="1"></label>巻上３　開く　（雨センサーなし）</td><td><a href="./#{name[2]}.cgi">#{yaml_dbr(name[2],"./config/#{name[2]}").to_s}</a></td><tr/>
<td>＜/td>
<td><label><input type="checkbox" name="config_5" value="1">bit 5</label></td>
<ts><td>
<td><label><input type="checkbox" name="manual_5" value="1"></label>巻上３　閉める（雨センサーなし）</td><td></td><tr/>

<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_6" value="1">bit 6</label></td>
<td><label><input type="checkbox" name="manual_6" value="1"></label>巻上４　開く　（雨センサーなし）</td><td><a href="./#{name[3]}.cgi">#{yaml_dbr(name[3],"./config/#{name[3]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_7" value="1">bit 7</label></td>
<td><label><input type="checkbox" name="manual_7" value="1"></label>巻上４　閉める（雨センサーなし）</td><td></td></tr>

<td><label><input type="checkbox" name="config_8" value="1">bit 8</label></td>
<td><label><input type="checkbox" name="manual_8" value="1"></label>巻上５　開く</td><td><a href="./#{name[4]}.cgi">#{yaml_dbr(name[4],"./config/#{name[4]}").to_s}</a></td><tr/>

<td><label><input type="checkbox" name="config_9" value="1">bit 9</label></td>
<td><label><input type="checkbox" name="manual_9" value="1"></label>巻上５　閉める</td><td></td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_A" value="1">bit A</label></td>
<td><label><input type="checkbox" name="manual_A" value="1"></label>巻上６　開く</td><td><a href="./#{name[5]}.cgi">#{yaml_dbr(name[5],"./config/#{name[5]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_B" value="1">bit B</label></td>
<td><label><input type="checkbox" name="manual_B" value="1"></label>巻上６　閉める</td><td></td></tr>

<td><label><input type="checkbox" name="config_C" value="1">bit C</label></td>
<td><label><input type="checkbox" name="manual_C" value="1"></label>巻上７　開く　（雨センサーなし）</td><td><a href="./#{name[6]}.cgi">#{yaml_dbr(name[6],"./config/#{name[6]}").to_s}</a></td><tr/>

<td><label><input type="checkbox" name="config_D" value="1">bit D</label></td>
<td><label><input type="checkbox" name="manual_D" value="1"></label>巻上７　閉める（雨センサーなし）</td><td></td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_E" value="1">bit E</label></td>
<td><label><input type="checkbox" name="manual_E" value="1"></label>巻上８　開く　（雨センサーなし）</td><td><a href="./#{name[7]}.cgi">#{yaml_dbr(name[7],"./config/#{name[7]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_F" value="1">bit F</label></td>
<td><label><input type="checkbox" name="manual_F" value="1"></label>巻上８　閉める（雨センサーなし）</td><td></td></tr>

<td><label><input type="checkbox" name="config_G" value="1">bit G</label></td>
<td><label><input type="checkbox" name="manual_G" value="1"></label>ＣＯ２機器１</td><td><a href="./#{name2[0]}.cgi">#{yaml_dbr(name2[0],"./config/#{name2[0]}").to_s}</a></td><tr/>

<td><label><input type="checkbox" name="config_H" value="1">bit H</label></td>
<td><label><input type="checkbox" name="manual_H" value="1"></label>ＣＯ２機器２</td><td><a href="./#{name2[1]}.cgi">#{yaml_dbr(name2[1],"./config/#{name2[1]}").to_s}</a></td><tr/>
<tr bgcolor="pink">
<td><label><input type="checkbox" name="config_I" value="1">bit I</label></td>
<td><label><input type="checkbox" name="manual_I" value="1"></label>暖房機１</td><td><a href="./#{name2[2]}.cgi">#{yaml_dbr(name2[2],"./config/#{name2[2]}").to_s}</a></td></tr>
<tr bgcolor="pink">
<td><label><input type="checkbox" name="config_J" value="1">bit J</label></td>
<td><label><input type="checkbox" name="manual_J" value="1"></label>暖房機２</td><td><a href="./#{name2[3]}.cgi">#{yaml_dbr(name2[3],"./config/#{name2[3]}").to_s}</a></td></tr>
<tr bgcolor="#bbbbff">
<td><label><input type="checkbox" name="config_K" value="1">bit K</label></td>
<td><label><input type="checkbox" name="manual_K" value="1"></label>換気扇１</td><td><a href="./#{name2[4]}.cgi">#{yaml_dbr(name2[4],"./config/#{name2[4]}").to_s}</a></td></tr>
<tr bgcolor="#bbbbff">
<td><label><input type="checkbox" name="config_L" value="1">bit L</label></td>
<td><label><input type="checkbox" name="manual_L" value="1"></label>換気扇２</td><td><a href="./#{name2[5]}.cgi">#{yaml_dbr(name2[5],"./config/#{name2[5]}").to_s}</a></td></tr>

<td><label><input type="checkbox" name="config_M" value="1">bit M</label></td>
<td><label><input type="checkbox" name="manual_M" value="1"></label>　循環扇１</td><td><a href="./#{name2[6]}.cgi">#{yaml_dbr(name2[6],"./config/#{name2[6]}").to_s}</a></td><tr/>

<td><label><input type="checkbox" name="config_N" value="1">bit N</label></td>
<td><label><input type="checkbox" name="manual_N" value="1"></label>　循環扇２</td><td><a href="./#{name2[7]}.cgi">#{yaml_dbr(name2[7],"./config/#{name2[7]}").to_s}</a></td><tr/>
<tr bgcolor="pink">
<td><label><input type="checkbox" name="config_O" value="1">bit Ｏ</label></td>
<td><label><input type="checkbox" name="manual_O" value="1"></label>温湯ボイラ</td><td><a href="./#{name2[8]}.cgi">#{yaml_dbr(name2[8],"./config/#{name2[8]}").to_s}</a></td></tr>


<td><label><input type="checkbox" name="config_P" value="1">bit P</label></td>
<td><label><input type="checkbox" name="manual_P" value="1"></label>カーテン１　開く</td><td><a href="./#{name3[0]}.cgi">#{yaml_dbr(name3[0],"./config/#{name3[0]}").to_s}</a></td><tr/>

<td><label><input type="checkbox" name="config_Q" value="1">bit Q</label></td>
<td><label><input type="checkbox" name="manual_Q" value="1"></label>カーテン１　閉じる</td><td><a href="./#{name3[1]}.cgi">#{yaml_dbr(name3[1],"./config/#{name3[1]}").to_s}</a></td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_R" value="1">bit R</label></td>
<td><label><input type="checkbox" name="manual_R" value="1"></label>カーテン２　開く</td><td><a href="./#{name3[2]}.cgi">#{yaml_dbr(name3[2],"./config/#{name3[2]}").to_s}</a></td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_S" value="1">bit S</label></td>
<td><label><input type="checkbox" name="manual_S" value="1"></label>カーテン２　閉じる</td><td><a href="./#{name3[3]}.cgi">#{yaml_dbr(name3[3],"./config/#{name3[3]}").to_s}</a></td></tr>
<td><label><input type="checkbox" name="config_T" value="1">bit T</label></td>
<td><label><input type="checkbox" name="manual_T" value="1"></label>電照１</td><td><a href="./#{name3[4]}.cgi">#{yaml_dbr(name3[4],"./config/#{name3[4]}").to_s}</a></td><tr/>
<td><label><input type="checkbox" name="config_U" value="1">bit U</label></td>
<td><label><input type="checkbox" name="manual_U" value="1"></label>電照２</td><td><a href="./#{name3[5]}.cgi">#{yaml_dbr(name3[5],"./config/#{name3[5]}").to_s}</a></td><tr/>
<td><label><input type="checkbox" name="config_V" value="1">bit V</label></td>
<td><label><input type="checkbox" name="manual_V" value="1"></label></td><tr/>

<table border="1">

     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./main.cgi">メインへ(手動状態は保持する)</a>
<br/>

</body></html>
eos

=begin
<td><label><input type="checkbox" name="config11" value="1">bit16</label></td>
<td><label><input type="checkbox" name="manual11" value="1"></label>電照2</td><tr/>
<td><label><input type="checkbox" name="config10" value="1">bit15</label></td>
<td><label><input type="checkbox" name="manual10" value="1"></label>電照1</td><tr/>

<td><label><input type="checkbox" name="config11" value="1">bit16</label></td>
<td><label><input type="checkbox" name="manual11" value="1"></label>電照2</td><tr/>
<td><label><input type="checkbox" name="config10" value="1">bit15</label></td>
<td><label><input type="checkbox" name="manual10" value="1"></label>電照1</td><tr/>

<td><label><input type="checkbox" name="config11" value="1">bit16</label></td>
<td><label><input type="checkbox" name="manual11" value="1"></label>電照2</td><tr/>
=end
