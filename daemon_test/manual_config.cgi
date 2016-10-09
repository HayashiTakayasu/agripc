#!/home/pi/.rvm/bin/ruby
#coding:utf-8

require "cgi"
value=File.read("config/config.txt")
#value=Dir.glob("../*")
print "Content-Type: text/html

"
#        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
print <<eos
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      

      <title>manual.cgi</title>
    </head>
    <body>
<h1>設定変更</h1>
  <form method="get" action="post_manual_config.cgi">
    <textarea type="text" name="text1" rows="10" cols="120" wrap="on">#{value}</textarea><br/>
    <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>

<hr/>
<a href="./main.cgi">メインへ(手動状態は保持する)</a>
<br/>

</body></html>
eos

