#!/home/pi/.rvm/bin/ruby
#coding:utf-8

require "cgi"
# $SAFE=1
cgi=CGI.new

text1=cgi["text1"]
print "Content-Type: text/html

"
#          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
print <<EOS

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        

        <title>post_manual_config.cgi</title>
      </head>
      <body>
EOS

print <<eos
<h1>config.txtセット完了</h1>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./manual_config.cgi">設定変更(setting)</a>
<hr/><pre>
#{text1}
</pre><hr/>
動作確認を願います<br/>

</body></html>
eos

open("config/config.txt","w"){|io| io.print text1}
