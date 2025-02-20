#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <ranges>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/stride_view.html

int main() {
    std::vector v = {0, 1, 2, 3, 4, 5, 6};

    for(auto&& i : v | std::views::stride(3)) {
        i *= 10;
    }

    for(const auto& x: v) {
        std::println("{}", x);
    }
}


#endif
