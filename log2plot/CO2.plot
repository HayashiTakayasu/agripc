#set terminal wxtenhanced
set key left top
#set xlabel
set terminal png size 640,480
set output "./CO2.png"

set datafile separator ","
set datafile missing "false"
set datafile commentschars "#"


set xdata time
set timefmt "%Y-%m-%d" 
set logscale y 10
#set boxwidth 0.7 absolute



set format x "%m/%d"
#set format y "10^(%L)"

#set xrange ["2012-10-01":"2013-1-10"]
#set yrange [10**(-1):10**(3)]
set autoscale
#set ytics -10,1,50
set grid
plot "./CO2" using 1:2 with lines title "Hour day:CO2","./CO2" using 1:3 with lines title "TOTAL:CO2" 

