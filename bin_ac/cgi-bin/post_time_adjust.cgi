#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
#require "./setting_io"
include AgriController

# $SAFE=1
cgi=CGI.new
text1=cgi["text1"]

print "Content-Type: text/html

"

print <<EOS

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>post_time_adjust.cgi</title>
      </head>
      <body>
EOS
#text2=CGI::unescapeHTML(text1)
str=%Q|sudo date -s "#{text1}";echo $?|
#print "<br/>"
res=`#{str}`
#print res.inspect+"<br/>" 

bool=res.split("\n").last

if bool=="0"
  system("sudo hwclock --systohc")
  #res1=`date`
  #res2=`sudo hwclock`
print "<h1>#{text1}  セット完了</h1>
動作確認を願います<br/>
"

print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos

else
  print "#{res}<br/>time text ERROR.</body></html>"
end