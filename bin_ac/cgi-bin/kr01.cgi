#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController
yaml_db("manual_bool01.txt","manual","./config/manual_bool01.txt")

print "Content-Type: text/html

"

print <<eos
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>kr01.cgi</title>
    </head>
    <body>
<h1>手動画面</h1><br/>
  <form method="get" action="post_kr01.cgi">
#KR01 Setting<br/>
<label><input type="checkbox" name="kr01_0" value="1">0</label>（排液切替信号)<br/>
<label><input type="checkbox" name="kr01_1" value="1">1</label>電磁弁１<br/>
<label><input type="checkbox" name="kr01_2" value="1">2</label>電磁弁２<br/>
<label><input type="checkbox" name="kr01_3" value="1">3</label>ポンプ信号<br/>
<br/>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./auto01.cgi">メイン（自動）へ</a>
<br/>

</body></html>
eos
