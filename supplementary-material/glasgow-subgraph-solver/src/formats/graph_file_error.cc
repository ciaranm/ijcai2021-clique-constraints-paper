/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "formats/graph_file_error.hh"
#include "formats/input_graph.hh"

#include <fstream>

using std::string;

GraphFileError::GraphFileError(const string & filename, const string & message, bool x) noexcept :
    _what("Error reading graph file '" + filename + "': " + message),
    _exists(x)
{
}

auto GraphFileError::what() const noexcept -> const char *
{
    return _what.c_str();
}

auto GraphFileError::file_at_least_existed() const noexcept -> bool
{
    return _exists;
}

