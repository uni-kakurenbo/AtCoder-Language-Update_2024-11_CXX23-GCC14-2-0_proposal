#include <algorithm>
#include <cassert>
#include <ranges>
using namespace std;

int main() {
    auto a = views::iota(0, 20);
    auto b = views::iota(0, 10);

    assert(ranges::starts_with(a, b));
}
