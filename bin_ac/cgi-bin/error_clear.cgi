#!ruby -Ku
#coding:utf-8
open("./log/errors.txt","w"){|io| io.print("")}
print "Content-Type: text/html\n\n"

print <<EOS 
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <META HTTP-EQUIV="Refresh" CONTENT="1;URL=./main.cgi">

        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>error_clear.cgi</title>
    </head>
    <body>
EOS

print 'エラー記録をリセットしました(すぐにメインへ戻ります)'
print <<eos
<hr/>
<a href="./main.cgi">メイン(main)</a>

</body></html>
eos