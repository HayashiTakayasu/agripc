#!ruby -Ku
#coding:utf-8

#require "cgi"
#require "./web"
#include AgriController
require "redis"
# $SAFE=1
print "Content-Type: text/html

"

print <<EOS

    <html>
      <head>
      </head>
      <body>
EOS
print "<h1>./config/halt</h1>
Please Wait...(Maybe 1 minutes later.)<br/>
</body>
"
db=Redis.new
db.rpush(:numato,"reset")
sleep 2
`sync;sync;sudo halt`
