#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <stdfloat>
#include <type_traits>
#include <print>


int main() {
    std::float128_t x = 1.0f128 / 1234567890;
    std::println("{}", x);

    static_assert(std::floating_point<std::float128_t>);
    static_assert(std::numeric_limits<std::float128_t>::digits == 113);
}


#endif
