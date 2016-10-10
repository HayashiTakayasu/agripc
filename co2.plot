#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot

set terminal png size 640,520 font '/usr/share/fonts/ipa-pgothic/ipagp.ttf'

set output "./thermo_data/co2.png"
set title "環境データ"
set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"
set key below
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"     # input

set format x "%H:%M"             # output
#set xrange ["2013-01-10 00:00":"2013-01-11 00:00"]
#set yrange [0:44]
#set ytics 0,10,2000
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
set style line 9 linecolor rgbcolor "black" linewidth 1
set style line 10 linecolor rgbcolor "green" linewidth 1
set style line 11 linecolor rgbcolor "blue" linewidth 1

#grey yellow light-green cyan magenta turquoise pink salmon khaki orange

plot "thermo_data/thermo_data2.txt" using 1:($2*20) with lines title "C(x20)" ls 1,\
     "thermo_data/thermo_data2.txt" using 1:($4) with lines title "CO2" ls 8 
     
     
