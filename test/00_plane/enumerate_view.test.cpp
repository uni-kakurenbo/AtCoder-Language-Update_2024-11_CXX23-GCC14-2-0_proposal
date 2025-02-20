#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <ranges>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/enumerate_view.html

int main() {
    const std::vector v = {'a', 'b', 'c'};

    for(const auto& [ i, x ] : v | std::views::enumerate) {
        std::println("{}: {}", i, x);
    }
}


#endif
