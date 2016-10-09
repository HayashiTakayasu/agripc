#!ruby -Ku
#coding:utf-8
require "redis"
#require "cgi"
#require "./web"
#include AgriController
# $SAFE=1
print "Content-Type: text/html

"

print <<EOS

    <html>
      <head>
      </head>
      <body>
EOS
print "<h1>./config/reboot</h1>
Please Wait...(Maybe few minutes later.)<br/>
</body>
"
db=Redis.new
db.rpush(:numato,"reset")
sleep 2
`sync;sync;sudo reboot`
