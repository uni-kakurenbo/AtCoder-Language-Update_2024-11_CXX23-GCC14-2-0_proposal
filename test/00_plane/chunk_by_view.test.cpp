#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <ranges>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/chunk_by_view.html

int main() {
    std::vector v = { 1, 2, 3, 4, 5, 6 };

    for(const auto& x : v | std::views::chunk_by(std::ranges::less_equal{})) {
        for(const auto& y : x) {
            std::println("{}", y);
        }
    }
}


#endif
