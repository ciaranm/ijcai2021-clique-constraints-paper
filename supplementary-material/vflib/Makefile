all : solve_vf solve_vf_induced

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread

solve_vf : solve_vf.cc
	$(CXX) $(CXXFLAGS) -o $@ -I vflib-2.0.6/include/ $< -L vflib-2.0.6/lib/ -lvf

solve_vf_induced : solve_vf_induced.cc
	$(CXX) $(CXXFLAGS) -o $@ -I vflib-2.0.6/include/ $< -L vflib-2.0.6/lib/ -lvf
