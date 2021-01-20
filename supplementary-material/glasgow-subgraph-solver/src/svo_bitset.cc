/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "svo_bitset.hh"

#include <algorithm>

using std::copy;

SVOBitset::SVOBitset(unsigned size, unsigned bits)
{
    n_words = (size + bits_per_word - 1) / (bits_per_word);
    if (n_words <= svo_size) {
        for (unsigned i = 0 ; i < svo_size ; ++i)
            _data.short_data[i] = bits;
    }
    else {
        _data.long_data = new BitWord[size];
        for (unsigned i = 0 ; i < size ; ++i)
            _data.long_data[i] = bits;
    }
}

