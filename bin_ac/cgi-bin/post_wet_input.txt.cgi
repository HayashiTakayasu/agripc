#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

# $SAFE=1
cgi=CGI.new
text1=cgi["text1"]

yaml_db("wet_input.txt",eval(text1),"./config/wet_input.txt")
yml=yaml_dbr("wet_input.txt","./config/wet_input.txt")
yml_value=yml.inspect
yaml_db("reload_flag",true,"./config/reload_flag")
print "Content-Type: text/html

"

print <<EOS

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>post_wet_input.txt.cgi</title>
      </head>
      <body>
EOS
print "<h1>./config/wet_input.txtセット完了</h1>
動作確認を願います<br/>
"
print yml_value
print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos
