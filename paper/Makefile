all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' -shell-escape paper

TABLES =

GRAPHS = \
	 gen-graph-cumulatives.pdf \
	 gen-graph-cumulatives-si.pdf \
	 gen-graph-cumulatives-local.pdf \
	 gen-graph-cumulatives-hom.pdf \
	 gen-graph-cumulatives-differences.pdf \
	 gen-graph-cumulatives-aggregate.pdf \
	 gen-graph-scatter-hom-c.pdf \
	 gen-graph-scatter-hom-cd.pdf \
	 gen-graph-scatter-local.pdf \
	 gen-graph-scatter-si.pdf

tables : $(TABLES)

graphs : differences aggregates $(GRAPHS)

differences : differences.cc
	$(CXX) -std=c++17 $(CXXFLAGS) $(LDFLAGS) -W -Wall -o $@ $<

aggregates : aggregates.cc
	$(CXX) -std=c++17 $(CXXFLAGS) $(LDFLAGS) -W -Wall -o $@ $<

gen-graph-%.pdf : graph-%.gnuplot
	gnuplot $<
	sed -i -e '19,20s/^\(\\path.*\)/\% \1/' gen-graph-$*.tex # epic haxx
	latexmk -pdf gen-graph-$*

