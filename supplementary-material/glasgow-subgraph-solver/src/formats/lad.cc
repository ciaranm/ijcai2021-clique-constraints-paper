/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "formats/lad.hh"
#include "formats/input_graph.hh"

#include <fstream>
#include <map>

using std::ifstream;
using std::map;
using std::pair;
using std::string;
using std::to_string;

namespace
{
    auto read_word(ifstream & infile) -> int
    {
        int x;
        infile >> x;
        return x;
    }

    auto read_any_lad(ifstream && infile, const string & filename,
            bool directed,
            bool vertex_labels,
            bool edge_labels) -> InputGraph
    {
        InputGraph result{ 0, vertex_labels, edge_labels };

        result.resize(read_word(infile));
        if (! infile)
            throw GraphFileError{ filename, "error reading size", true };

        for (int r = 0 ; r < result.size() ; ++r) {
            if (vertex_labels) {
                int l = read_word(infile);
                if (! infile)
                    throw GraphFileError{ filename, "error reading label", true };

                result.set_vertex_label(r, to_string(l));
            }

            int c_end = read_word(infile);
            if (! infile)
                throw GraphFileError{ filename, "error reading edges count", true };

            for (int c = 0 ; c < c_end ; ++c) {
                int e = read_word(infile);

                if (e < 0 || e >= result.size())
                    throw GraphFileError{ filename, "edge index out of bounds", true };

                if (edge_labels) {
                    int l = read_word(infile);
                    if (l < 0)
                        throw GraphFileError{ filename, "edge label invalid", true };

                    result.add_directed_edge(r, e, to_string(l));
                }
                else if (directed)
                    result.add_directed_edge(r, e, "");
                else
                    result.add_edge(r, e);
            }
        }

        string rest;
        if (infile >> rest)
            throw GraphFileError{ filename, "EOF not reached, next text is \"" + rest + "\"", true };
        if (! infile.eof())
            throw GraphFileError{ filename, "EOF not reached", true };

        return result;
    }
}

auto read_lad(ifstream && infile, const string & filename) -> InputGraph
{
    return read_any_lad(move(infile), filename, false, false, false);
}

auto read_directed_lad(ifstream && infile, const string & filename) -> InputGraph
{
    return read_any_lad(move(infile), filename, true, false, false);
}

auto read_labelled_lad(ifstream && infile, const string & filename) -> InputGraph
{
    return read_any_lad(move(infile), filename, true, true, true);
}

auto read_vertex_labelled_lad(ifstream && infile, const string & filename) -> InputGraph
{
    return read_any_lad(move(infile), filename, false, true, false);
}

