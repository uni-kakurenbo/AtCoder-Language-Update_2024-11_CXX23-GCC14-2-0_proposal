#include <cassert>


namespace non_literal_variables_in_constexpr_function {


constexpr int f(int x) {
    if consteval {
        return x;
    } else {
        thread_local int n = x;
        return n + x;
    }
}


} // namespace non_literal_variables_in_constexpr_function


int main() {
    using namespace non_literal_variables_in_constexpr_function;

    static_assert(f(1));
    assert(f(1));
}
