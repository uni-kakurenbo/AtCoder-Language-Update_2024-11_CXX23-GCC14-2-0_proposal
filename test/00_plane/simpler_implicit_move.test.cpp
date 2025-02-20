#include <concepts>


namespace simpler_implicit_move{


struct movable {
    movable() = default;
    movable(movable&&);
};

struct rvalue_reference_qualified_convertible {
    int x = 0;
    operator int&() && {
        return this->x;
    };
};


movable&& implicitly_move_local_rvalue_reference(movable&& x) {
    return x;
}

int& implicitly_move_local_value_with_convertion(rvalue_reference_qualified_convertible x) {
    return x;
}


auto return_movable_expression(int n) -> auto&& {
  return n;
}

auto return_parentheses_enclosed_expression(int n) -> decltype(auto) {
    return (n);
}


} // namespace simpler_implicit_move


int main() {
    using namespace simpler_implicit_move;

    static_assert(std::same_as<decltype(implicitly_move_local_rvalue_reference({})), movable&&>);
    static_assert(std::same_as<decltype(implicitly_move_local_value_with_convertion({})), int&>);

    static_assert(std::same_as<decltype(return_movable_expression({})), int&&>);
    static_assert(std::same_as<decltype(return_parentheses_enclosed_expression({})), int&&>);
}
