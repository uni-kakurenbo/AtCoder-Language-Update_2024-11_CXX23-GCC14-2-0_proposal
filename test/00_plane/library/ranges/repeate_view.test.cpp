#include <print>
#include <ranges>


int main() {
    for(const auto& x : std::views::repeat(0, 10)) {
        std::println("{}", x);
    }
}
