Having built all the solvers, run the following:

    make -f Makefile.gss
    make -f Makefile.lad
    make -f Makefile.ri
    make -f Makefile.vf2
    make -f Makefile.stats
    make -f Makefile.plots
    ../glasgow-subgraph-solver/plot_glasgow_solver_outputs instances.txt $(ls -d results/gss-* )

This will create a 'runtimes.data' and an 'otherruntimes.data' which you can
use to replace the ones in the paper directory.

You may wish to set the TIMEOUT variable to something lower than its default of 3600.
