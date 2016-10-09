#!ruby -Ku
#coding:utf-8

require "cgi"
require "./web"
require "./setting_io"
include AgriController

print "Content-Type: text/html

"

print <<eos

    <html>
      <head>
        <meta http-equiv="Content-Language" content="ja" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        
          <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
        <title>time_adjust.cgi</title>
      </head>
      <body>
<h1>時刻を設定</h1>
年／月／日    、    時：分（＊＊：＊＊）  、  時：分：秒でも記述可。<a href="http://www.geocities.jp/gronlijus/skill/linux/linux-set-date.html">linux　date -s 設定について調べる</a>
<br/>
hwclock:#{`sudo hwclock`}<br>
sysdate:#{Time.now}

<h3>内部時計の時刻(書式の例) <br/>
<SCRIPT LANGUAGE="javascript" TYPE="text/javascript">
<!--
var Nowymdhms　=　new Date();
var NowYear = Nowymdhms.getYear()+1900;
var NowMon = Nowymdhms.getMonth() + 1;
var NowDay = Nowymdhms.getDate();
var NowWeek = Nowymdhms.getDay();
var NowHour = Nowymdhms.getHours();
var NowMin = Nowymdhms.getMinutes();
var NowSec = Nowymdhms.getSeconds();
var Week = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");





if(NowMon < 10){
	NowMon = "0"+NowMon;
}
if(NowDay < 10){
	NowDay = "0"+NowDay;
}
if(NowHour < 10){
	NowHour = "0"+NowHour;
}
if(NowMin < 10){
	NowMin = "0"+NowMin;
}
if(NowSec < 10){
	NowSec = "0"+NowSec;
}



document.write(NowYear+"/"+NowMon+"/"+NowDay+" "+NowHour+":"+NowMin+":"+NowSec)
// -->
</SCRIPT></h3>
  <form method="get" action="post_time_adjust.cgi">
     <textarea type="text" name="text1" rows="1" cols="50" wrap="off">
</textarea><br/>
     <input type="submit" value="送信post" />
     <input type="reset" value="クリアclear"/>
  </form>
<hr/>
<a href="./main.cgi">メイン(main)</a>
<br/>
<a href="./setting.cgi">設定変更(setting)</a>

</body></html>
eos
