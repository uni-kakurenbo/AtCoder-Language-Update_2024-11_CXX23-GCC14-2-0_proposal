#include <algorithm>


// ref: https://cpprefjp.github.io/lang/cpp23/consteval_needs_to_propagate_up.html


consteval bool is_even(int x) {
  return x % 2 == 0;
}


int main() {
    constexpr int ar[] = {1, 3, 5};


    static_assert(
        std::ranges::none_of(
            ar,
            [](int x) { return is_even(x); }
        )
    );


    static_assert(
        std::ranges::none_of(
            ar,
            [](int x) consteval { return is_even(x); }
        )
    );


    static_assert(std::ranges::none_of(ar, is_even));
}
