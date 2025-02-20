#include <cassert>
#include <list>
#include <print>
#include <ranges>
#include <unordered_map>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/zip_view.html

int main() {
    std::vector v = {1, 2};
    const std::list l = {'a', 'b', 'c'};

    for(auto &&[i, c] : std::views::zip(v, l)) {
        i *= 10;
    }

    for(const auto& [ i, x ]: std::views::zip(v, l)) {
        std::println("{}: {}", i, x);
    }

    assert(std::ranges::size(std::views::zip()) == 0uz);
}
