#include <algorithm>
#include <cassert>
#include <ranges>

#ifdef __clang__

using namespace std;

#else

#include <range/v3/algorithm/starts_with.hpp>

#endif

int main() {
    auto a = std::views::iota(0, 20);
    auto b = std::views::iota(0, 10);

    assert(ranges::starts_with(a, b));
}
