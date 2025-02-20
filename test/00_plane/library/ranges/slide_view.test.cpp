#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <ranges>
#include <vector>


int main() {
    std::vector v = { 1, 2, 3, 4, 5, 6 };


    for(const auto& x : v | std::views::slide(2)) {
        for(const auto& y : x) {
            std::println("{}", y);
        }
    }
}


#endif
