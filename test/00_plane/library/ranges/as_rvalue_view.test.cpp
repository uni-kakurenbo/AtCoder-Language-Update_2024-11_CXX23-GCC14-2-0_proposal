#include <iterator>
#include <print>
#include <ranges>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/as_rvalue_view.html

int main() {
    using namespace std;

    vector<string> words = { "the", "quick", "brown", "fox", "ate", "a", "pterodactyl" };
    vector<string> new_words;

    ranges::copy(words | views::as_rvalue, back_inserter(new_words));

    for(const auto& x : new_words) {
        print("{}", x);
    }
}
