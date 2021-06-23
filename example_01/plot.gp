set terminal postscript enhanced color font 'Times,26'

set output "spectrum.eps"

set xrange [40:160]
set yrange [0:70000]

set xlabel "{/Symbol l} [nm]"
# set ylabel "{/Symbol e}_k [L mol^{-1} cm^{-1}]"
set ylabel "{/Symbol e} [L mol^{-1} cm^{-1}]"

set samples 1000

plot 'spectrum.dat' w l notitle lw 2 lc rgb "red", \
     'spectrumstick.dat' w i title "stick spectrum" lc rgb "black"
