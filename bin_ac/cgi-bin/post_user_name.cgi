#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

# $SAFE=1
cgi=CGI.new

#cgi["text1"]
text1=cgi["text1"].gsub(/(\s)/,"")

#yaml_db("house1",eval(text1),"./config/house1")
#yml=yaml_dbr("house1","./config/house1")
#yml_value=yml.inspect
#yaml_db("reload_flag",true,"./config/reload_flag")
name=text1
open("./config/user_name.txt","w"){|io| io.print name.chomp}

print "Content-Type: text/html

"

print <<EOS

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>post_user_name.cgi</title>
      </head>
      <body>
EOS
print "<h1>./config/user_nameセット完了</h1>
#{name}<br/>
動作確認を願います<br/>
"
print 
print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos