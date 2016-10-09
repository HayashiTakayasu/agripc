#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
open("manual_bool02.txt","w"){|io| io.puts("manual")}

print "Content-Type: text/html

"

print <<eos
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>kr02.cgi</title>
    </head>
    <body>
<h1>手動kr02画面</h1><br/>
  <form method="get" action="post_kr02.cgi">
<br/>
#KR02 Setting<br/>
<label><input type="checkbox" name="kr02_0" value="1">0</label>ハウス１モーター開方向セット<br/>
<label><input type="checkbox" name="kr02_1" value="1">1</label>-<br/>
<label><input type="checkbox" name="kr02_2" value="1">2</label>ハウス２モーター開方向セット<br/>
<label><input type="checkbox" name="kr02_3" value="1">3</label>-<br/>

<label><input type="checkbox" name="kr02_4" value="1">4</label>-<br/>
<label><input type="checkbox" name="kr02_5" value="1">5</label>-<br/>
<label><input type="checkbox" name="kr02_6" value="1">6</label>-<br/>
<label><input type="checkbox" name="kr02_7" value="1">7</label>-<br/>

<br/>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./auto02.cgi">メイン（自動）へ</a>
<br/>

</body></html>
eos
