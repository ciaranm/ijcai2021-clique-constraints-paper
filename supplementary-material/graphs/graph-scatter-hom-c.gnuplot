# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 1.9in,2.3in font '\scriptsize' preamble '\input{gnuplot-preamble}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "viridis.pal"

timeout=3600e3

# set xlabel "Runtime Before (ms)"
# set ylabel "Runtime With Clique and Distance (ms)"
set border 3
set grid
set xtics nomirror
set ytics nomirror
set key off
set xrange [1e0:2*timeout]
set yrange [1e0:2*timeout]
set logscale xy
set format x '$10^{%T}$'
set format y '$10^{%T}$'
set size square
set nocolorbox
set ytics offset character 1

sx(s,m)=stringcolumn(s)eq"instance"?NaN:stringcolumn(s)eq"NaN"?2*timeout:column(s)*m>=timeout?2*timeout:column(s)*m
getpt(c)=stringcolumn(c)[1:2]eq"si"?1:stringcolumn(c)[1:1]eq"g"?2:stringcolumn(c)[1:5]eq"phase"?6:stringcolumn(c)[1:10]eq"all-meshes"?8:stringcolumn(c)[1:10]eq"all-images"?10:stringcolumn(c)[1:4]eq"PR15"?12:stringcolumn(c)[2:2]eq"."?14:3
getlc(c)=stringcolumn(c)[1:2]eq"si"?1:stringcolumn(c)[1:1]eq"g"?2:stringcolumn(c)[1:5]eq"phase"?3:stringcolumn(c)[1:10]eq"all-meshes"?4:stringcolumn(c)[1:10]eq"all-images"?5:stringcolumn(c)[1:4]eq"PR15"?6:stringcolumn(c)[2:2]eq"."?7:stringcolumn(c)eq"instance"?1:-1

set title "Homomorphism (Cliques)"

plot \
    "runtimes.data" u (sx("fatanode-results/gss-noninjective-nosupplementals-20210111",1)):(sx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)):(getpt("instance")):(getlc("instance")) w p pt var lc pal ps 0.5, \
    x w l ls -1

