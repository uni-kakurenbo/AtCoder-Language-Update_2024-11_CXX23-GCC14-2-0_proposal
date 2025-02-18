#include <algorithm>
#include <cassert>
#include <ranges>


#ifdef __clang__


using std::ranges::starts_with;


#else


#include <range/v3/algorithm/starts_with.hpp>
using ranges::starts_with;


#endif


int main() {
    auto a = std::views::iota(0, 20);
    auto b = std::views::iota(0, 10);

    assert(starts_with(a, b));
}
