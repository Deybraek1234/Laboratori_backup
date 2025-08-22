 set terminal pngcairo enhanced font "arial,10"
 set output 'computation_time_kind4.png'

set title "Tempo di Computazione per Metodo (Kind=4)"
set xlabel "N° di Iterazioni"
set ylabel "Velocità (s)"

set logscale xy

set grid

set key outside right top

plot 'computation_time_data_kind4.txt' using 1:2 with linespoints title "Programma Completo", \
     '' using 1:3 with linespoints title "Rapporto Incrementale", \
     '' using 1:4 with linespoints title "Differenza Simmetrica", \
     '' using 1:5 with linespoints title "Estrapolazione di Richardson"
