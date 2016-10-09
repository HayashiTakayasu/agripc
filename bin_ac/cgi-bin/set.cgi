#!ruby -Ku
#coding:utf-8

print "Content-Type: text/html\n\n"
print <<EOS
    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>setting.cgi</title>
      </head>
      <body>
<h1>設定</h1>
潅水設定<br/>
<a href=./time_array.cgi>　時刻、秒</a><br/>
<a href=./wait_time.cgi>　潅水次段待ち</a><br/>
<a href=./wet0_drain.cgi>　排液センサー１</a><br/>
<a href=./wet1_drain.cgi>　排液センサー２</a><br/>

<br/>
巻上器設定<br/>
<a href=./house1.cgi>ハウス１　N段サーモ</a><br/>
<a href=./house2.cgi>ハウス２　N段サーモ</a><br/>

<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./reset_.cgi">設定初期化</a>
</body></html>
EOS

