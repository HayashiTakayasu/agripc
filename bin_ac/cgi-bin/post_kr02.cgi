#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController
# $SAFE=1
cgi=CGI.new
kr02_0=cgi["kr02_0"].to_i.to_s
kr02_1=cgi["kr02_1"].to_i.to_s
kr02_2=cgi["kr02_2"].to_i.to_s
kr02_3=cgi["kr02_3"].to_i.to_s
kr02_4=cgi["kr02_4"].to_i.to_s
kr02_5=cgi["kr02_5"].to_i.to_s
kr02_6=cgi["kr02_6"].to_i.to_s
kr02_7=cgi["kr02_7"].to_i.to_s
kr_02=(kr02_7+kr02_6+kr02_5+kr02_4+kr02_3+kr02_2+kr02_1+kr02_0).to_i(2).to_s(16).upcase
yaml_db("kr2_bit.txt",kr_02,"./config/kr2_bit.txt")
yaml_db("kr02_readable.txt","OK","./config/kr02_readable.txt")


print "Content-Type: text/html

"

print <<EOS

  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>post_kr02.cgi</title>
    </head>
    <body>
EOS
print "<h1>手動データ送信</h1>
動作確認を願います<br/>
"
print <<EOS
#{kr02_7}
#{kr02_6}
#{kr02_5}
#{kr02_4}

#{kr02_3}
#{kr02_2}
#{kr02_1}
#{kr02_0} =>#{kr_02}
<br/>
EOS

print <<eos
<hr/>
<a href="./kr02.cgi">戻る(kr02)</a><br/>
<a href="./auto02.cgi">メイン（自動）へ</a>
<br/>
</body></html>
eos
