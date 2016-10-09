#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController
#b0=Bit.new(yaml_dbr("manual_dacs0-0.txt","./config/manual_dacs0-0.txt"))
#b1=Bit.new(yaml_dbr("manual_dacs0-1.txt","./config/manual_dacs0-1.txt"))
#bit_bool=b0.tos(2,24)|| 0
#bit=b1.tos(2,24) || 0
#flag:#{bit_bool}<br/>
#bit :#{bit}<br/>
#{b0.inspect}<br/>
#{b1.inspect}<br/>

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
　※起動時や､エラーの際は、自動モードに戻ります。仕様変更する場合はご依頼ください。<br/>

<table border="1">
<td>手動にする</td><td>オン・オフ</td><td>　　　　</td><td>手動にする</td><td>オン・オフ</td><tr/>

<td><label><input type="checkbox" name="config_0" value="1">bit 0</label></td>
<td><label><input type="checkbox" name="manual_0" value="1">pump</label>（ポンプ信号)</td><td>　　　　</td>
<td> </td>
<td> </td><tr/>

<td><label><input type="checkbox" name="config_1" value="1">bit 1</label></td>
<td><label><input type="checkbox" name="manual_1" value="1">valve1</label>（電磁弁1)</td><td>　　　　</td>
<td><label><input type="checkbox" name="config_9" value="1">bit 9</label></td>
<td><label><input type="checkbox" name="manual_9" value="1">open_1</label>（モーター１開信号)</td><tr/>

<td><label><input type="checkbox" name="config_2" value="1">bit 2</label></td>
<td><label><input type="checkbox" name="manual_2" value="1">valve2</label>（電磁弁2)</td><td>　　　　</td>
<td><label><input type="checkbox" name="config10" value="1">bit１0</label></td>
<td><label><input type="checkbox" name="manual10" value="1">stop１</label>（モーター1ストップ信号)</td><tr/>

<td><label><input type="checkbox" name="config_3" value="1">bit 3</label></td>
<td><label><input type="checkbox" name="manual_3" value="1">valve3</label>（電磁弁3)</td><td>　　　　</td>
<td><label><input type="checkbox" name="config11" value="1">bit11</label></td>
<td><label><input type="checkbox" name="manual11" value="1">open_2</label>（モーター2開信号)</td><tr/>

<td><label><input type="checkbox" name="config_4" value="1">bit 4</label></td>
<td><label><input type="checkbox" name="manual_4" value="1">valve4</label>（電磁弁4)</td><td>　　　　</td>
<td><label><input type="checkbox" name="config12" value="1">bit12</label></td>
<td><label><input type="checkbox" name="manual12" value="1">stop2</label>（モーター2ストップ信号)</td><tr/>
<table border="1">

     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./main.cgi">メインへ(手動状態は保持する)</a>
<br/>

</body></html>
eos
