#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <cassert>
#include <list>
#include <print>
#include <ranges>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/cartesian_product_view.html

int main() {
    std::vector v = {1, 2};
    const std::list l = {'a', 'b', 'c'};

    for(const auto& [ i, x ] : std::views::cartesian_product(v, l)) {
        std::println("({}, {})", i, x);
    }

    assert(std::views::cartesian_product().size() == 1);
}


#endif
