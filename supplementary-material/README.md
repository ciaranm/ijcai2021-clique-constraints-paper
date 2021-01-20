Description of Supplementary Material
=====================================

This archive contains:

- Our modified version of the Glasgow Subgraph Solver.

- The supporting helper programs to run other solvers, together with instructions on how to download
  and build the other solvers. (Not all other solvers allow direct redistribution.)

- Instructions on how to download the instances. (These are too large to include with the submission
  file size limit, but for the final version of the paper they will be included in the DOI.)

- The scripts needed to run the experiments and parse the outputs.

- The Gnuplot files needed to plot these outputs.

To reproduce all of the experiments on a recent Linux system, follow the instructions in the
following directories, in order.  Firstly, download the instances as described in the instances
directory. Next, run 'make' in the glasgow-subgraph-solver directory (check the README.md in that
directory for dependency and compiler information). Then, follow the instructions in each of the
pathLAD, ri, and vflib directories to build other solvers. Finally, follow the instructions in the
'experiments' directory to actually run the experiments.

Notes on the Reproducibility Checklist
--------------------------------------

We have tried to answer the reproducibility checklist as best we can, but there is no "not
applicable" option for some of the entries. We did not check the following boxes for the following
reasons:

"Proofs of all novel claims are included and complete.": the results of some of the propositions in
the paper are extremely straightforward to verify, and so proofs are not given.

"Appropriate citations to theoretical tools used are given.": we did not use any such tools.

8. Reproducibility -- Data sets

"All novel datasets introduced in this paper are described in detail in a data appendix, including
the collecting procedure and data statistics.": we use existing public datasets.

"All novel datasets introduced in this paper will be made publicly available upon publication of the
paper with a license that allows free usage for research purposes.": we do not make new datasets
available, although the existing datasets we use comply with this requirement.

"All datasets that are not publicly available are described in details.": all our datasets are
publicly available.

"The preprocessing details of datasets are included.": no preprocessing is performed.

"Details of Train/Valid/Test splits are included.": this is not machine learning, there is no train
/ valid / test splitting.

"The input and output, mathematical setting, and algorithms are clearly introduced.": we are not
sure exactly what this means.

"The complexity analysis including time, space, and sample size is presented.": we are in
NP-complete territory, and our work has no effect upon theoretical complexity analysis.

"Detailed hyperparameter settings of algorithms are described, including the ranges and how to
select the best ones.": there are no hyperparemters involved.

"The number of training and inference runs are stated explicitly. [only applied for papers related
to machine learning]": not machine learning.

"Average training and inference time. [only applied for papers related to machine learning]": not
machine learning.
