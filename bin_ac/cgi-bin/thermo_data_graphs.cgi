#!ruby -Ku
#coding:utf-8

#require "web"
#require "thermo_gruff"
require "date"


filelist=Dir.glob("../htdocs/thermo/*.jpg").sort.reverse
print "Content-Type: text/html

"

print <<EOS 
  <html>
    <head>
      <meta http-equiv="Content-Language" content="ja" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="../css/str.css" title="str"/>
      <title>thermo_data_list.cgi</title>
    </head>
    <body>(名称順）<br/>
EOS
if filelist.size!=0
  filelist.each do |file|
  name=File.basename(file)
  
  print <<EOS
<img src="../thermo/#{name}" alt="thermo/#{name}"/>
EOS
  
  end
end
print <<eos
<hr/>#{DateTime.now.to_s}
<a href="./main.cgi">メイン(main)</a>
<a href="./thermo_graph.cgi">戻る(thermo_graph)</a><br/>
<a href="./thermo_data_graphs.cgi">画像リスト(注：遅いです！こまめに整理してください)</a>

</body></html>
eos
