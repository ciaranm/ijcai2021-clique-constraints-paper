/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <optional>
#include <string>
#include <utility>
#include <vector>

using std::cout;
using std::endl;
using std::ifstream;
using std::nullopt;
using std::optional;
using std::pair;
using std::string;
using std::vector;

auto get(ifstream & s) -> optional<pair<unsigned, unsigned> >
{
    string tok, tok2, _;
    while (true) {
        if (! (s >> tok))
            return nullopt;
        if (tok != "#")
            break;
        getline(s, _);
    }
    s >> tok2;
    getline(s, _);
    return pair{ stoi(tok), stoi(tok2) };
}

auto main(int argc, char * argv[]) -> int
{
    if (3 != argc)
        return EXIT_FAILURE;

    ifstream f1{ argv[1] }, f2{ argv[2] };

    vector<unsigned> v1, v2;
    for (auto d1 = get(f1) ; d1 ; d1 = get(f1)) {
        while (v1.size() < d1->first)
            v1.push_back(v1.back());
        v1.push_back(d1->second);
    }

    for (auto d2 = get(f2) ; d2 ; d2 = get(f2)) {
        while (v2.size() < d2->first)
            v2.push_back(v2.back());
        v2.push_back(d2->second);
    }

    while (v1.size() < v2.size())
        v1.push_back(v1.back());
    while (v2.size() < v1.size())
        v2.push_back(v2.back());

    for (unsigned i = 0 ; i < v1.size() ; ++i)
        cout << i << " " << v1[i] << " " << v2[i] << endl;

    return EXIT_SUCCESS;
}

