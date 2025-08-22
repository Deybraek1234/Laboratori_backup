# Gnuplot script to plot numerical derivatives and their errors

# Set terminal to pngcairo for high-quality PNG output
set terminal pngcairo size 1200, 800 font "Arial,12"

# Set common plot settings
set xlabel "h"
set ylabel "Valore Derivata"
set grid
set logscale x # Use log scale for x-axis (h) to better visualize convergence
set key autotitle columnhead # Use the header from the data file for legend titles (if available, otherwise use explicit titles)

# --- Plot for fort.10 (f1 a x = 2.34654, exact derivative = 0) ---
set output "p1f1.png"
set title "Derivata di f1 a x = 2.34654"
plot "fort.10" using 1:3  title "Rapporto incrementale (+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)", \
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     0.0

# --- Plot for fort.11 (f2 a x = 7.36143, exact derivative = 0.00002492587) ---
set output "p1f2.png"
set title "Derivata di f2 a x = 7.36143"
plot "fort.11" using 1:3  title "Rapporto incrementale (+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)", \
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson",\
     0.00002492587

# --- Plot for fort.12 (f3 ax = 50.0, exact derivative = 0.03472757134) ---
set output "p1f3.png"
set title "Derivata di f3 a x = 50.0"
plot "fort.12" using 1:3  title "Rapporto incrementale (+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)", \
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson",\
     0.03472757134

# --- Plot for fort.13 (f1 a x = pi, exact derivative = -31.0062766803) ---
set output "p2f1.png"
set title "Derivata di f1 a x = pi"
plot "fort.13" using 1:3  title "Rapporto incrementale (+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)", \
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     -31.0062766803

# --- Plot for fort.14 (f2 a x = 8.8, exact derivative = 10.69306698751) ---
set output "p2f2.png"
set title "Derivata di f2 a x = 8.8"
plot "fort.14" using 1:3  title "Rapporto incrementale (+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)", \
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     10.69306698751

# --- Plot for fort.15 (f3 a x = 7.5, exact derivative = 0.22704715192) ---
set output "p2f3.png"
set title "Derivata di f3 a x = 7.5"
plot "fort.15" using 1:3  title "Rapporto incrementale(+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)", \
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     0.22704715192

# --- Plot for fort.16 (f1 a x = -pi, exact derivative = 31.0062766803) ---
set output "p3f1.png"
set title "Derivata di f1 a x = -pi"
plot "fort.16" using 1:3  title "Rapporto incrementale(+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)",\
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     31.0062766803

# --- Plot for fort.17 (f2 a x = -8.8, exact derivative = -0.69306698751) ---
set output "p3f2.png"
set title "Derivata di f2 a x = -8.8"
plot "fort.17" using 1:3  title "Rapporto incrementale(+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)",\
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     -0.69306698751

# --- Plot for fort.18 (f3 a x = 0.01, exact derivative = 173.697796760) ---
set output "p3f3.png"
set title "Derivata di f3 a x = 0.01"
plot "fort.18" using 1:3  title "Rapporto incrementale(+h)", \
     "" using 1:6 title "Rapporto incrementale (-h)",\
     "" using 1:4  title "Differenza Simmetrica", \
     "" using 1:5  title "Estrapolazione di Richardson", \
     173.697796760
