#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot

set terminal png size 640,520 font '/usr/share/fonts/ipa-pgothic/ipagp.ttf'

set output "./thermo_data/thermo_data.csv.png"
set title "環境データ"
set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"
set key below
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"     # input

set format x "%H:%M"             # output
#set xrange ["2013-01-10 00:00":"2013-01-11 00:00"]
set yrange [0:44]
set ytics 0,2,40
set grid xtics ytics
set xtics rotate by -60
#set ymtics 2
set style line 1 linecolor rgbcolor "black" linewidth 2
set style line 2 linecolor rgbcolor "green" linewidth 2
set style line 3 linecolor rgbcolor "blue" linewidth 2
set style line 4 linecolor rgbcolor "red" 
set style line 5 linecolor rgbcolor "navy"
set style line 6 linecolor rgbcolor "salmon"
set style line 7 linecolor rgbcolor "magenta" 
set style line 8 linecolor rgbcolor "dark-green" linewidth 2

#grey yellow light-green cyan magenta turquoise pink salmon khaki orange

plot "thermo_data/thermo_data2.txt" using 1:2 with lines title "温度 ℃" ls 1 ,\
     "thermo_data/thermo_data2.txt" using 1:6 with lines title "地温℃" ls 2,\
     "thermo_data/thermo_data2.txt" using 1:($3/3) with lines title "湿度(1/3)"  ls 3,\
     "thermo_data/thermo_data2.txt" using 1:($4/100) with lines title "ppm(1/100)" ls 8,\
     "thermo_data/thermo_data2.txt" using 1:5 with lines title "飽差g/m3" ls 4
#     "thermo_data/thermo_data2.txt" using 1:7 with lines title "温度(1)℃" ls 7,\
#     "thermo_data/thermo_data2.txt" using 1:10 with lines title "温度(2)℃" ls 8,\
#     "thermo_data/thermo_data2.txt" using 1:13 with lines title "温度(3)℃" ls 9
     
     
     
