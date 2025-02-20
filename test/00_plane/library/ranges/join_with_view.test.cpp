#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <ranges>
#include <string>
#include <vector>


// ref: https://cpprefjp.github.io/reference/ranges/join_with_view.html

int main() {
    using namespace std;
    vector<string> sv = {"hello", "world"};

    for(char c : sv | views::join_with('-')) {
        println("{}", c);
    }
}




#endif
