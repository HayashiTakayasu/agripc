#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

print "Content-Type: text/html

"

print <<eos
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>manual.cgi</title>
    </head>
    <body>
<h1>手動画面</h1>
  <form method="get" action="post_manual.cgi">
#manual Setting<br/>手動にする所をチェックし、on・offを指示してください。<br/>


<table border="1">
<td>手動にする</td><td>オン・オフ</td><td><tr/>

<td><label><input type="checkbox" name="config_0" value="1">bit 0</label></td>
<td><label><input type="checkbox" name="manual_0" value="1"></label>巻上１　開く</td><tr/>
<td><label><input type="checkbox" name="config_1" value="1">bit 1</label></td>
<td><label><input type="checkbox" name="manual_1" value="1"></label>巻上１　閉める</td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_2" value="1"></label>bit 2</td>
<td><label><input type="checkbox" name="manual_2" value="1"></label>巻上２　開く</td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_3" value="1">bit 3</label></td>
<td><label><input type="checkbox" name="manual_3" value="1"></label>巻上２　閉める</td></tr>

<td><label><input type="checkbox" name="config_4" value="1">bit 4</label></td>
<td><label><input type="checkbox" name="manual_4" value="1"></label>巻上３　開く　（雨センサーなし）</td><tr/>

<td><label><input type="checkbox" name="config_5" value="1">bit 5</label></td>
<td><label><input type="checkbox" name="manual_5" value="1"></label>巻上３　閉める（雨センサーなし）</td><tr/>

<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_6" value="1">bit 6</label></td>
<td><label><input type="checkbox" name="manual_6" value="1"></label>巻上４　開く　（雨センサーなし）</td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_7" value="1">bit 7</label></td>
<td><label><input type="checkbox" name="manual_7" value="1"></label>巻上４　閉める（雨センサーなし）</td></tr>

<td><label><input type="checkbox" name="config_8" value="1">bit 8</label></td>
<td><label><input type="checkbox" name="manual_8" value="1"></label>巻上５　開く</td><tr/>

<td><label><input type="checkbox" name="config_9" value="1">bit 9</label></td>
<td><label><input type="checkbox" name="manual_9" value="1"></label>巻上５　閉める</td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_A" value="1">bit A</label></td>
<td><label><input type="checkbox" name="manual_A" value="1"></label>巻上６　開く</td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_B" value="1">bit B</label></td>
<td><label><input type="checkbox" name="manual_B" value="1"></label>巻上６　閉める</td></tr>

<td><label><input type="checkbox" name="config_C" value="1">bit C</label></td>
<td><label><input type="checkbox" name="manual_C" value="1"></label>巻上７　開く　（雨センサーなし）</td><tr/>

<td><label><input type="checkbox" name="config_D" value="1">bit D</label></td>
<td><label><input type="checkbox" name="manual_D" value="1"></label>巻上７　閉める（雨センサーなし）</td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_E" value="1">bit E</label></td>
<td><label><input type="checkbox" name="manual_E" value="1"></label>巻上８　開く　（雨センサーなし）</td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_F" value="1">bit F</label></td>
<td><label><input type="checkbox" name="manual_F" value="1"></label>巻上８　閉める（雨センサーなし）</td></tr>

<td><label><input type="checkbox" name="config_G" value="1">bit G</label></td>
<td><label><input type="checkbox" name="manual_G" value="1"></label>ＣＯ２機器１</td><tr/>

<td><label><input type="checkbox" name="config_H" value="1">bit H</label></td>
<td><label><input type="checkbox" name="manual_H" value="1"></label>ＣＯ２機器２</td><tr/>
<tr bgcolor="pink">
<td><label><input type="checkbox" name="config_I" value="1">bit I</label></td>
<td><label><input type="checkbox" name="manual_I" value="1"></label>暖房機１</td></tr>
<tr bgcolor="pink">
<td><label><input type="checkbox" name="config_J" value="1">bit J</label></td>
<td><label><input type="checkbox" name="manual_J" value="1"></label>暖房機２</td></tr>
<tr bgcolor="#bbbbff">
<td><label><input type="checkbox" name="config_K" value="1">bit K</label></td>
<td><label><input type="checkbox" name="manual_K" value="1"></label>換気扇１</td></tr>
<tr bgcolor="#bbbbff">
<td><label><input type="checkbox" name="config_L" value="1">bit L</label></td>
<td><label><input type="checkbox" name="manual_L" value="1"></label>換気扇２</td></tr>

<td><label><input type="checkbox" name="config_M" value="1">bit M</label></td>
<td><label><input type="checkbox" name="manual_M" value="1"></label>　循環扇１</td><tr/>

<td><label><input type="checkbox" name="config_N" value="1">bit N</label></td>
<td><label><input type="checkbox" name="manual_N" value="1"></label>　循環扇２</td><tr/>
<tr bgcolor="pink">
<td><label><input type="checkbox" name="config_O" value="1">bit Ｏ</label></td>
<td><label><input type="checkbox" name="manual_O" value="1"></label>温湯ボイラ</td></tr>


<td><label><input type="checkbox" name="config_P" value="1">bit P</label></td>
<td><label><input type="checkbox" name="manual_P" value="1"></label>カーテン１　開く</td><tr/>

<td><label><input type="checkbox" name="config_Q" value="1">bit Q</label></td>
<td><label><input type="checkbox" name="manual_Q" value="1"></label>カーテン１　閉じる</td><tr/>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_R" value="1">bit R</label></td>
<td><label><input type="checkbox" name="manual_R" value="1"></label>カーテン２　開く</td></tr>
<tr bgcolor="#ffffc0">
<td><label><input type="checkbox" name="config_S" value="1">bit S</label></td>
<td><label><input type="checkbox" name="manual_S" value="1"></label>カーテン２　閉じる</td></tr>
<td><label><input type="checkbox" name="config_T" value="1">bit T</label></td>
<td><label><input type="checkbox" name="manual_T" value="1"></label>電照１</td><tr/>
<td><label><input type="checkbox" name="config_U" value="1">bit U</label></td>
<td><label><input type="checkbox" name="manual_U" value="1"></label>電照２</td><tr/>
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
