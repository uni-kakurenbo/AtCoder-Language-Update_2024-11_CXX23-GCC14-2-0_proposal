#include <cassert>


namespace static_constexpr_variables_in_constexpr_functions {


constexpr auto f(int i) {
    static constexpr char STR[] = "ABC";
    return STR[i];
}


} // namespace static_constexpr_variables_in_constexpr_functions


int main() {
    using namespace static_constexpr_variables_in_constexpr_functions;

    assert(f(0) == 'A');
}
