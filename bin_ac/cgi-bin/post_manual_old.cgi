#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController
# $SAFE=1
cgi=CGI.new
bit_0_bool=cgi["config_0"].to_i.to_s
bit_0     =cgi["manual_0"].to_i.to_s

bit_1_bool=cgi["config_1"].to_i.to_s
bit_1     =cgi["manual_1"].to_i.to_s

bit_2_bool=cgi["config_2"].to_i.to_s
bit_2     =cgi["manual_2"].to_i.to_s

bit_3_bool=cgi["config_3"].to_i.to_s
bit_3     =cgi["manual_3"].to_i.to_s

bit_4_bool=cgi["config_4"].to_i.to_s
bit_4     =cgi["manual_4"].to_i.to_s

bit_5_bool=cgi["config_5"].to_i.to_s
bit_5     =cgi["manual_5"].to_i.to_s

bit_6_bool=cgi["config_6"].to_i.to_s
bit_6     =cgi["manual_6"].to_i.to_s

bit_7_bool=cgi["config_7"].to_i.to_s
bit_7     =cgi["manual_7"].to_i.to_s

bit_8_bool=cgi["config_8"].to_i.to_s
bit_8     =cgi["manual_8"].to_i.to_s

bit_9_bool=cgi["config_9"].to_i.to_s
bit_9     =cgi["manual_9"].to_i.to_s

bit10_bool=cgi["config10"].to_i.to_s
bit10     =cgi["manual10"].to_i.to_s

bit11_bool=cgi["config11"].to_i.to_s
bit11     =cgi["manual11"].to_i.to_s

bit_bool=bit11_bool+bit10_bool+bit_9_bool+bit_8_bool+bit_7_bool+bit_6_bool+
         bit_5_bool+bit_4_bool+bit_3_bool+bit_2_bool+bit_1_bool+bit_0_bool
         
bit     =bit11+bit10+bit_9+bit_8+bit_7+bit_6+
         bit_5+bit_4+bit_3+bit_2+bit_1+bit_0

yaml_db("manual_dacs0-0.txt",bit_bool.to_i(2),"./config/manual_dacs0-0.txt")
yaml_db("manual_dacs0-1.txt",bit.to_i(2)     ,"./config/manual_dacs0-1.txt")


print "Content-Type: text/html

"

print <<EOS

  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>post_manual.cgi</title>
    </head>
    <body>
EOS
print "<h1>手動データ送信</h1>
動作確認を願います<br/>
"
print <<EOS
#{bit_bool}<br/>
#{bit}
<br/>
EOS

print <<eos
<hr/>
<a href="./manual.cgi">戻る(manual　手動)</a><br/>
<a href="./main.cgi">メインへ(手動状態は保持する)</a>
<br/>
</body></html>
eos
