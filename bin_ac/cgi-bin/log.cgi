#!ruby -Ku
#coding:utf-8

log_file="./log/log.txt"
begin
  dat=File.read(log_file)
  x=dat.split("\n").reverse
rescue
  last_data="read ERROR.May be file busy.try NEXT"
end
print "Content-Type: text/html\n\n"
print '<a href="./kr_log.cgi">KR command log</a><><a href="./main.cgi">Main HTML</a><br/>
<br/>'
x.each do |str|
print str+"<br/>\n"
end
print <<EOS 
<a href="./main.cgi">Main HTML</a><br/>
EOS
