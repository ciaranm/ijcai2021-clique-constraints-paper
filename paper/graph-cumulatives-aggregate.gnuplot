# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 2.1in,2.6in font '\scriptsize' preamble '\input{gnuplot-preamble}'

timeout=3600e3

cx(s,m)=stringcolumn(s)eq"NaN"?timeout:column(s)*m>=timeout?timeout:column(s)*m
cy(s,m)=stringcolumn(s)eq"NaN"?1e-10:column(s)*m>=timeout?1e-10:1

set format x '%.0f'
set format y '%.0f'

set xrange [1:timeout]
set yrange [0:14621] noextend

set table 'gen-graph-cumulative-aggregate-gss-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-20210102",1)):(cy("fatanode-results/gss-20210102",1)) smooth cum
set table 'gen-graph-cumulative-aggregate-gss-cliques-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-20210102",1)):(cy("fatanode-results/gss-cliques-20210102",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-locallyinjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-locallyinjective-20210102",1)):(cy("fatanode-results/gss-locallyinjective-20210102",1)) smooth cum
set table 'gen-graph-cumulative-aggregate-gss-cliques-locallyinjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-locallyinjective-20210102",1)):(cy("fatanode-results/gss-cliques-locallyinjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-noninjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-20210102",1)):(cy("fatanode-results/gss-noninjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-cliques-noninjective-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-20210102",1)):(cy("fatanode-results/gss-cliques-noninjective-20210102",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-noninjective-nosupplementals-20210102",1)):(cy("fatanode-results/gss-noninjective-nosupplementals-20210102",1)) smooth cum

set table 'gen-graph-cumulative-aggregate-gss-cliques-noninjective-nosupplementals-20210102.data'
plot "runtimes.data" u (cx("fatanode-results/gss-cliques-noninjective-nosupplementals-20210102",1)):(cy("fatanode-results/gss-cliques-noninjective-nosupplementals-20210102",1)) smooth cum

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

set style fill transparent solid 0.3 noborder

plot \
    1 w l ls -1, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-20210102.data gen-graph-cumulative-aggregate-gss-cliques-20210102.data | uniq -f1' u 1:2 w l ls 1 ti "SI" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-locallyinjective-20210102.data gen-graph-cumulative-aggregate-gss-cliques-locallyinjective-20210102.data | uniq -f1' u 1:2 w l ls 4 ti "Local" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210102.data gen-graph-cumulative-aggregate-gss-cliques-noninjective-nosupplementals-20210102.data | uniq -f1' u 1:2 w l ls 7 ti "Hom+C" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210102.data gen-graph-cumulative-aggregate-gss-noninjective-20210102.data | uniq -f1' u 1:2 w l ls 8 ti "Hom+D" at end, \
    '<./aggregates gen-graph-cumulative-aggregate-gss-noninjective-nosupplementals-20210102.data gen-graph-cumulative-aggregate-gss-cliques-noninjective-20210102.data | uniq -f1' u 1:2 w l ls 9 ti "Hom+CD" at end

