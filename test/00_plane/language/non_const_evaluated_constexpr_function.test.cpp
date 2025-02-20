#include <optional>


namespace non_const_evaluated_constexpr_function {


template<typename T>
constexpr void f(std::optional<T>& optional) {
    optional.reset();
}


} // namespace non_const_evaluated_constexpr_function


int main() {
    using namespace non_const_evaluated_constexpr_function;

    std::optional<int> v = 0;
    f(v);
}
