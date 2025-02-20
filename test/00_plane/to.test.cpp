#include <print>
#include <ranges>
#include <string>
#include <string_view>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/to.html

int main() {
    using namespace std;
    using namespace std::literals;

    auto str = "the quick brown fox"sv;
    auto words = views::split(str, ' ') | ranges::to<vector<string>>();

    for(const auto& word: words) {
        println("{}", word);
    }
}
