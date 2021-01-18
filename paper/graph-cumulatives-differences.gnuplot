# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.1in,2.6in font '\scriptsize' preamble '\input{gnuplot-preamble}'

timeout=3600e3

cx(s,m)=stringcolumn(s)eq"NaN"?timeout:column(s)*m>=timeout?timeout:column(s)*m
cy(s,m)=stringcolumn(s)eq"NaN"?1e-10:column(s)*m>=timeout?1e-10:1

set format x '%.0f'
set format y '%.0f'

set xrange [1:timeout]
set yrange [0:14621] noextend

set table 'gen-graph-cumulative-differences-gss-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-20210111",1)):(cy("fatanode-results/gss-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-20210111",1)):(cy("fatanode-results/gss-cliques-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-locallyinjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-locallyinjective-20210111",1)):(cy("fatanode-results/gss-locallyinjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-locallyinjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-locallyinjective-20210111",1)):(cy("fatanode-results/gss-cliques-locallyinjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-noninjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-20210111",1)):(cy("fatanode-results/gss-noninjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-noninjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-20210111",1)):(cy("fatanode-results/gss-cliques-noninjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-nosupplementals-20210111",1)):(cy("fatanode-results/gss-noninjective-nosupplementals-20210111",1)) smooth cum

set table 'gen-graph-cumulative-differences-gss-cliques-noninjective-nosupplementals-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)):(cy("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)) smooth cum

unset table

set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "viridis.pal"

set xlabel "Runtime (ms)"
set ylabel "Relative Instances Solved" offset character .5
set border 3
set grid
set xtics nomirror
set ytics nomirror
set key off
set xrange [1e0:timeout]
set yrange [0:450]
set logscale x
set format x '$10^{%T}$'
set xtics add ('~1h' 3600e3)

set style fill transparent solid 0.3 noborder

set title 'Additional Instances Solved'

plot \
    0 w l ls -1, \
    '<./differences gen-graph-cumulative-differences-gss-20210111.data gen-graph-cumulative-differences-gss-cliques-20210111.data' u 1:($3-$2) w l ls 1 lw 2 ti '\raisebox{1mm}{SI}' at end, \
    '<./differences gen-graph-cumulative-differences-gss-locallyinjective-20210111.data gen-graph-cumulative-differences-gss-cliques-locallyinjective-20210111.data' u 1:($3-$2) w l ls 4 lw 2 ti '\raisebox{-1mm}{LI+Clq}' at end, \
    '<./differences gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210111.data gen-graph-cumulative-differences-gss-cliques-noninjective-nosupplementals-20210111.data' u 1:($3-$2) w l ls 7 lw 2 ti "H+Clq" at end, \
    '<./differences gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210111.data gen-graph-cumulative-differences-gss-noninjective-20210111.data' u 1:($3-$2) w l ls 8 lw 2 ti "H+Dst" at end, \
    '<./differences gen-graph-cumulative-differences-gss-noninjective-nosupplementals-20210111.data gen-graph-cumulative-differences-gss-cliques-noninjective-20210111.data' u 1:($3-$2) w l ls 9 lw 2 ti "H+Both" at end

