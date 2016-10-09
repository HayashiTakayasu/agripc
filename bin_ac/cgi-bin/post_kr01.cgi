#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController
# $SAFE=1
cgi=CGI.new
kr01_0=cgi["kr01_0"].to_i.to_s
kr01_1=cgi["kr01_1"].to_i.to_s
kr01_2=cgi["kr01_2"].to_i.to_s
kr01_3=cgi["kr01_3"].to_i.to_s
kr_01=(kr01_3+kr01_2+kr01_1+kr01_0).to_i(2).to_s(16).upcase
yaml_db("kr1_bit.txt",kr_01,"./config/kr1_bit.txt")
yaml_db("kr01_readable.txt","OK","./config/kr01_readable.txt")


print "Content-Type: text/html

"

print <<EOS

  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>post_kr01.cgi</title>
    </head>
    <body>
EOS
print "<h1>手動データ送信</h1>
動作確認を願います<br/>
"
print <<EOS
#{kr01_3}
#{kr01_2}
#{kr01_1}
#{kr01_0}　　　　　=>#{kr_01}
<br/>
EOS

print <<eos
<hr/>
<a href="./kr01.cgi">戻る(kr01)</a><br/>
<a href="./auto01.cgi">メイン（自動）へ</a>
<br/>
</body></html>
eos
