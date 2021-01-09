# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.0in,2.0in font '\scriptsize' preamble '\input{gnuplot-preamble}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

timeout=3600e3

load "viridis.pal"

set xlabel "Runtime (ms)"
set ylabel "Instances Solved" offset character .5
set border 3
set grid
set xtics nomirror
set ytics nomirror
set key off
set xrange [1e3:timeout]
set yrange [14050:14550] noextend
set logscale x
set format x '$10^{%T}$'
set xtics add ('1h' 3600e3)

cx(s,m)=stringcolumn(s)eq"NaN"?timeout:column(s)*m>=timeout?timeout:column(s)*m
cy(s,m)=stringcolumn(s)eq"NaN"?1e-10:column(s)*m>=timeout?1e-10:1

set style fill transparent solid 0.3 noborder

set title "Homomorphism"

plot \
    "runtimes.data" u (cx("fatanode-results/gss-noninjective-nosupplementals-20210102",1)):(cy("fatanode-results/gss-noninjective-nosupplementals-20210102",1)) smooth cum w l ls 7 lw 1 ti "None" at end, \
    "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210102",1)):(cy("fatanode-results/gss-cliques-noninjective-nosupplementals-20210102",1)) smooth cum w l ls 7 lw 2 ti "Clq" at end, \
    "runtimes.data" u (cx("fatanode-results/gss-noninjective-20210102",1)):(cy("fatanode-results/gss-noninjective-20210102",1)) smooth cum w l ls 8 lw 2 ti "Dist" at end, \
    "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-20210102",1)):(cy("fatanode-results/gss-cliques-noninjective-20210102",1)) smooth cum w l ls 8 lw 3 ti "Both" at end, \

