#include <print>
#include <string>
#include <range/v3/algorithm/for_each.hpp>

int main() {
    const std::string msg = "Hello, world.";

    ranges::for_each(msg, [](auto c) { std::print("{} ", c); });
    std::println();
}
