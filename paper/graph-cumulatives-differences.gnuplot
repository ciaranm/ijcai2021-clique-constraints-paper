# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.1in,2.6in font '\scriptsize' preamble '\input{gnuplot-preamble}'

timeout=3600e3

cx(s,m)=stringcolumn(s)eq"NaN"?timeout:column(s)*m>=timeout?timeout:column(s)*m
cy(s,m)=stringcolumn(s)eq"NaN"?1e-10:column(s)*m>=timeout?1e-10:1

set format x '%.0f'
set format y '%.0f'

set xrange [1:timeout]
set yrange [0:14621] noextend

set table 'gen-graph-cumulative-differences-gss-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-20210102",1)):(cy("fatanode-results/gss-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-20210102",1)):(cy("fatanode-results/gss-cliques-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-locallyinjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-locallyinjective-20210102",1)):(cy("fatanode-results/gss-locallyinjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-locallyinjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-locallyinjective-20210102",1)):(cy("fatanode-results/gss-cliques-locallyinjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-noninjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-20210102",1)):(cy("fatanode-results/gss-noninjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-noninjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-20210102",1)):(cy("fatanode-results/gss-cliques-noninjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-nosupplementals-20210102",1)):(cy("fatanode-results/gss-noninjective-nosupplementals-20210102",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-noninjective-nosupplementals-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210102",1)):(cy("fatanode-results/gss-cliques-noninjective-nosupplementals-20210102",1)) smooth cum

unset table

set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "viridis.pal"

set xlabel "Runtime (ms)"
set ylabel "Relative Instances Solved" offset character 1.5
set border 3
set grid
set xtics nomirror
set ytics nomirror
set key off
set xrange [1e0:timeout]
set yrange [-2500:500]
set logscale x
set format x '$10^{%T}$'

ygapsize=60
lowerygap=-1960
upperygap=-900
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

plot \
    0 w l ls -1, \
    '<./differences gen-graph-cumulative-differences-gss-20210102.data gen-graph-cumulative-differences-gss-cliques-20210102.data' u 1:($3-$2) w l ls 1 ti "SI" at end, \
    '<./differences gen-graph-cumulative-differences-gss-locallyinjective-20210102.data gen-graph-cumulative-differences-gss-cliques-locallyinjective-20210102.data' u 1:($3-$2) w l ls 4 ti "Local" at end, \
    '<./differences gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210102.data gen-graph-cumulative-differences-gss-cliques-noninjective-nosupplementals-20210102.data' u 1:($3-$2) w l ls 7 ti "Hom+C" at end, \
    '<./differences gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210102.data gen-graph-cumulative-differences-gss-noninjective-20210102.data' u 1:($3-$2) w l ls 8 ti "Hom+D" at end, \
    '<./differences gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210102.data gen-graph-cumulative-differences-gss-cliques-noninjective-20210102.data' u 1:($3-$2) w l ls 9 ti "Hom+CD" at end

