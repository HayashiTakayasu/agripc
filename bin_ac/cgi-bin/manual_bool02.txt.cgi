#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

yml=yaml_dbr("manual_bool02.txt","./config/manual_bool02.txt")
yml_value=yml.inspect
print "Content-Type: text/html

"

print <<eos

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>manual_bool02.txt.cgi</title>
      </head>
      <body>
<h1>./config/manual_bool02.txtを設定</h1>
間違った変更をすると動作しません！
設定例：<br/>
#{yml_value}<br/><br/>
  <form method="get" action="post_manual_bool02.txt.cgi">
     <textarea type="text" name="text1" rows="1" cols="50" wrap="off">
#{yml_value}</textarea><br/>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos
