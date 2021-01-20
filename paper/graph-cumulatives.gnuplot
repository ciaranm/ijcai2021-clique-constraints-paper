# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.1in,2.6in font '\scriptsize' preamble '\input{gnuplot-preamble}'
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
set xrange [1:timeout]
set yrange [0:14621] noextend
set logscale x
set format x '$10^{%T}$'
set ytics add ('$14621$' 14621)
set xtics add ('~1h' 3600e3)

cx(s,m)=stringcolumn(s)eq"NaN"?timeout:column(s)*m>=timeout?timeout:column(s)*m
cy(s,m)=stringcolumn(s)eq"NaN"?1e-10:column(s)*m>=timeout?1e-10:1

ygapsize=250
lowerygap=2700
upperygap=8950
ygap(i)=(i<=lowerygap)?i:(i<upperygap)?NaN:(i-upperygap+lowerygap+ygapsize)
yinvgap(i)=(i<=lowerygap)?i:(i<lowerygap+ygapsize)?NaN:(i+upperygap-lowerygap-ygapsize)
set nonlinear y via ygap(y) inverse yinvgap(y)
set object 500 rect from graph 0, first lowerygap to graph 1, first upperygap fs solid noborder fc bgnd front
set arrow 501 from graph 0, first lowerygap to graph 0, first upperygap lw 2 lc bgnd nohead front
set arrow 502 from graph 1, first lowerygap to graph 1, first upperygap lw 2 lc bgnd nohead front
set arrow 503 from graph 0, first lowerygap length graph  .03 angle 15 nohead lw 2 front
set arrow 504 from graph 0, first lowerygap length graph -.03 angle 15 nohead lw 2 front
set arrow 505 from graph 0, first upperygap length graph  .03 angle 15 nohead lw 2 front
set arrow 506 from graph 0, first upperygap length graph -.03 angle 15 nohead lw 2 front

set style fill transparent solid 0.3 noborder

set title 'Cumulative Instances Solved'

plot \
    "<head -n2 runtimes.data" u (3600e3):(14500) w p ps 0 lc rgb 'white' ti '\} See below' at end, \
    "runtimes.data" u (cx("fatanode-results/gss-locallyinjective-20210111",1)):(cy("fatanode-results/gss-locallyinjective-20210111",1)) smooth cum w l ls 4 lw 1 ti "LI", \
    "runtimes.data" u (cx("fatanode-results/gss-cliques-locallyinjective-20210111",1)):(cy("fatanode-results/gss-cliques-locallyinjective-20210111",1)) smooth cum w l ls 4 lw 2 ti "LI+Clq", \
    "runtimes.data" u (cx("fatanode-results/gss-noninjective-nosupplementals-20210111",1)):(cy("fatanode-results/gss-noninjective-nosupplementals-20210111",1)) smooth cum w l ls 7 lw 1 ti "H", \
    "runtimes.data" u (cx("fatanode-results/gss-noninjective-20210111",1)):(cy("fatanode-results/gss-noninjective-20210111",1)) smooth cum w l ls 8 lw 2 ti "H+Dst", \
    "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)):(cy("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)) smooth cum w l ls 7 lw 2 ti "H+Clq", \
    "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-20210111",1)):(cy("fatanode-results/gss-cliques-noninjective-20210111",1)) smooth cum w l ls 9 lw 2 ti "H+Both", \
    "runtimes.data" u (cx("fatanode-results/gss-20210111",1)):(cy("fatanode-results/gss-20210111",1)) smooth cum w l ls 1 lw 1 ti "SI", \
    "runtimes.data" u (cx("fatanode-results/gss-cliques-20210111",1)):(cy("fatanode-results/gss-cliques-20210111",1)) smooth cum w l ls 1 lw 2 ti "SI+Clq", \
    "otherruntimes.data" u (cx("vf2",1000)):(cy("vf2",1000)) smooth cum w l ls 3 dt "." ti 'SI, VF2' at end, \
    "otherruntimes.data" u (cx("ri",1000)):(cy("ri",1000)) smooth cum w l ls 5 dt "." ti '\raisebox{-0.5mm}{SI, RI}' at end, \
    "otherruntimes.data" u (cx("pathlad",1000)):(cy("pathlad",1000)) smooth cum w l ls 6 dt "." ti '\raisebox{-1mm}{SI, PathLAD}' at end, \

