#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot
set title "2013-02-03 00:00:00 +0900"
set terminal png size 640,480
set output "thermo_data.csv.20130203.plot.png"

set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"     # input

set format x "%H:%M"             # output
set xrange ["2013-02-03 00:00":"2013-02-04 00:00"]
#set ytics -5,1,25
set grid xtics ytics
plot "thermo_data.csv.20130203" using 1:2 with lines title "1:Celsius Degree",\
     "thermo_data.csv.20130203" using 1:($3/3) with lines title "  Humidity(1/3)",\
     "thermo_data.csv.20130203" using 1:4 with lines title "2:Celsius Degree",\
     "log.txt.20130203.txt" using 1:2 with steps notitle,\
     "log.txt.20130203.txt" using 1:3 with steps notitle,\
     "log.txt.20130203.txt" using 1:4 with steps notitle,\
     "log.txt.20130203.txt" using 1:5 with steps notitle,\
     "log.txt.20130203.txt" using 1:6 with steps notitle,\
     "log.txt.20130203.txt" using 1:7 with steps notitle,\
     "log.txt.20130203.txt" using 1:8 with steps notitle,\
     "log.txt.20130203.txt" using 1:9 with steps notitle,\
     "log.txt.20130203.txt" using 1:10 with steps notitle,\
     "log.txt.20130203.txt" using 1:11 with steps notitle,\
     "log.txt.20130203.txt" using 1:12 with steps notitle
#     "log.txt.20130203.txt" using 1:13 with steps notitle,\
#     "log.txt.20130203.txt" using 1:14 with steps notitle,\
#     "log.txt.20130203.txt" using 1:15 with steps notitle,\
#     "log.txt.20130203.txt" using 1:16 with steps notitle,\
#     "log.txt.20130203.txt" using 1:17 with steps notitle,\
#     "log.txt.20130203.txt" using 1:18 with steps notitle,\
#     "log.txt.20130203.txt" using 1:19 with steps notitle,\
#     "log.txt.20130203.txt" using 1:20 with steps notitle,\
#     "log.txt.20130203.txt" using 1:21 with steps notitle,\
#     "log.txt.20130203.txt" using 1:22 with steps notitle,\
#     "log.txt.20130203.txt" using 1:23 with steps notitle,\
#     "log.txt.20130203.txt" using 1:24 with steps notitle,\
#     "log.txt.20130203.txt" using 1:25 with steps notitle
