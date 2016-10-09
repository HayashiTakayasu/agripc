#Create a New style graphic with GNUPLOT.
#this way
#>gnuplot sample.plot

set terminal png size 680,480 font '/usr/share/fonts/ipa-pgothic/ipagp.ttf'

set output "../htdocs/co2.png"
set title "CO2濃度設定"
set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"
set key below
set xdata time
set timefmt "%H:%M"     # input

set format x "%H:%M"             # output
set xtics rotate by -60
#set xrange ["2013-01-10 00:00":"2013-01-11 00:00"]
set yrange [0:2000]
set ytics 0,100,2000
set grid xtics ytics
set mxtics 2
set style line 1 linecolor rgbcolor "black" linewidth 2
set style line 2 linecolor rgbcolor "green" linewidth 2
set style line 3 linecolor rgbcolor "blue" linewidth 2
set style line 4 linecolor rgbcolor "red"
set style line 5 linecolor rgbcolor "orange"
set style line 6 linecolor rgbcolor "purple"
set style line 7 linecolor rgbcolor "navy"
set style line 8 linecolor rgbcolor "dark-green" linewidth 2

#grey yellow light-green cyan magenta turquoise pink salmon khaki 

plot "./co2.txt" using 1:2 with steps title "ppm" ls 1 
#     "thermo_data/thermo_data.csv" using 1:($4/100) with lines title "ppm(1/100)" ls 2,\
#     "thermo_data/thermo_data.csv" using 1:($3/3) with lines title "湿度(1/3)"  ls 3,\
#     "thermo_data/thermo_data.csv" using 1:5 with lines title "飽差g/m3" ls 4,\
#     "thermo_data/thermo_data.csv" using 1:6 with lines title "露点℃" ls 3,\
#     "thermo_data/thermo_data.csv" using 1:7 with lines title "絶対湿度g/m3" ls 5,\
#     "log/co2.txt" using 1:2 with steps title "CO2 Bit" linestyle 6,\
#     "log/fan.txt" using 1:2 with steps title "換気Bit" ls 7

