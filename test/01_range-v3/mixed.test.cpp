#include <print>
#include <string>
#include <ranges>
#include <range/v3/algorithm/for_each.hpp>
#include <range/v3/view/concat.hpp>
#include <range/v3/view/cycle.hpp>
#include <range/v3/view/take.hpp>
#include <range/v3/range/conversion.hpp>

int main() {
    const std::string a = "ABCD";
    const std::string b = "1234";

    std::println(
        "{}",
        ranges::views::concat(a, b) |
            ranges::views::cycle |
            std::views::drop(10) |
            std::views::take(13) |
            std::ranges::to<std::string>()
    );
}
