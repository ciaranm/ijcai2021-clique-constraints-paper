# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.1in,2.6in font '\scriptsize' preamble '\input{gnuplot-preamble}'

timeout=3600e3

cx(s,m)=stringcolumn(s)eq"NaN"?timeout:column(s)*m>=timeout?timeout:column(s)*m
cy(s,m)=stringcolumn(s)eq"NaN"?1e-10:column(s)*m>=timeout?1e-10:1

set format x '%.0f'
set format y '%.0f'

set xrange [1:timeout]
set yrange [0:14621] noextend

set table 'gen-graph-cumulative-aggregate-gss-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-20210111",1)):(cy("fatanode-results/gss-20210111",1)) smooth cum
set table 'gen-graph-cumulative-aggregate-gss-cliques-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-20210111",1)):(cy("fatanode-results/gss-cliques-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-count-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-count-20210111",1)):(cy("fatanode-results/gss-count-20210111",1)) smooth cum
set table 'gen-graph-cumulative-aggregate-gss-count-cliques-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-count-cliques-20210111",1)):(cy("fatanode-results/gss-count-cliques-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-locallyinjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-locallyinjective-20210111",1)):(cy("fatanode-results/gss-locallyinjective-20210111",1)) smooth cum
set table 'gen-graph-cumulative-aggregate-gss-cliques-locallyinjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-locallyinjective-20210111",1)):(cy("fatanode-results/gss-cliques-locallyinjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-count-locallyinjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-count-locallyinjective-20210111",1)):(cy("fatanode-results/gss-count-locallyinjective-20210111",1)) smooth cum
set table 'gen-graph-cumulative-aggregate-gss-count-cliques-locallyinjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-count-cliques-locallyinjective-20210111",1)):(cy("fatanode-results/gss-count-cliques-locallyinjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-noninjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-20210111",1)):(cy("fatanode-results/gss-noninjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-cliques-noninjective-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-20210111",1)):(cy("fatanode-results/gss-cliques-noninjective-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-nosupplementals-20210111",1)):(cy("fatanode-results/gss-noninjective-nosupplementals-20210111",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-cliques-noninjective-nosupplementals-20210111.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)):(cy("fatanode-results/gss-cliques-noninjective-nosupplementals-20210111",1)) smooth cum

unset table

set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "viridis.pal"

set xlabel "Runtime (ms)"
set ylabel "Aggregate Speedup" offset character 1
set border 3
set grid
set xtics nomirror
set ytics nomirror
set key off
set xrange [1:timeout]
unset yrange
set logscale x
set format x '$10^{%T}$'
unset format y
set logscale y
set xtics add ('~1h' 3600e3)
set format y '$%.0f\times$'
set ytics offset character 0.5

set title 'Aggregate Speedup'

set style fill transparent solid 0.3 noborder

plot \
    1 w l ls -1, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-20210111.data gen-graph-cumulative-aggregate-gss-cliques-20210111.data | uniq -f1' u 1:2 w l ls 1 lw 2 ti "SI+Clq" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-locallyinjective-20210111.data gen-graph-cumulative-aggregate-gss-cliques-locallyinjective-20210111.data | uniq -f1' u 1:2 w l ls 4 lw 2 ti "LI+Clq" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210111.data gen-graph-cumulative-aggregate-gss-cliques-noninjective-nosupplementals-20210111.data | uniq -f1' u 1:2 w l ls 7 lw 2 ti "H+Clq" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210111.data gen-graph-cumulative-aggregate-gss-noninjective-20210111.data | uniq -f1' u 1:2 w l ls 8 lw 2 ti "H+Dst" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210111.data gen-graph-cumulative-aggregate-gss-cliques-noninjective-20210111.data | uniq -f1' u 1:2 w l ls 9 lw 2 ti "H+Both" at end

