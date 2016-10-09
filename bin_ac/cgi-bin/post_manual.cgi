#!ruby -Ku
#coding:utf-8
require "redis"
require "cgi"
require "./web"
require "./setting_io"
include AgriController
# $SAFE=1

db=Redis.new
cgi=CGI.new

bit_bool=""
bit=""
32.times do |i|
  char=i.to_s(32).upcase
  b0=cgi["config_#{char}"].to_i.to_s
  b1=cgi["manual_#{char}"].to_i.to_s
  bit_bool=b0+bit_bool
       bit=b1+bit
end

yaml_db("manual_0.txt",bit_bool.to_i(2),"./config/manual_0.txt")
yaml_db("manual_1.txt",bit.to_i(2)     ,"./config/manual_1.txt")
b_m0=db.get("manual_0")
b_m1=db.get("manual_0")
#b=db.get("numato_bit")
db.set("manual_0",bit_bool)
db.set("manual_1",bit)

##manual set
32.times do |i|
  char=i.to_s(32).upcase
  if b_m0[-i-1]=="1" && bit_bool[-i-1]=="0"
    if b_m1[-i-1]=="0"
      #db.rpush(:numato,"relay on #{char}")
    else
      db.rpush(:numato,"relay off #{char}")
    end 
  end  
  if bit_bool[-i-1]=="1"
    if bit[-i-1]=="1"
      db.rpush(:numato,"relay on #{char}")
    else
      db.rpush(:numato,"relay off #{char}")
    end 
  end
end



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
