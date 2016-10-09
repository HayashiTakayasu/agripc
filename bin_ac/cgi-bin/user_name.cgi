#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

#yml=yaml_dbr("username","./config/house1")
#yml_value=yml.inspect
`touch ./config/user_name.txt`
name=File.read("./config/user_name.txt")
if name.size>2
 name=name.slice(1,name.size-1)
end

print "Content-Type: text/html

"

print <<eos

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>user_name.cgi</title>
      </head>
      <body>
<h1>./config/user_nameを設定</h1>
間違った変更をすると動作しません！
設定例：<br/>
#{name}<br/><br/>
  <form method="get" action="post_user_name.cgi">
     <textarea type="text" name="text1" rows="1" cols="50" wrap="off">
#{name}</textarea><br/>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos
