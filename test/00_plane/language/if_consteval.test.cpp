#include <cassert>


constexpr bool if_consteval() {
    if consteval {
        return true;
    }
    else {
        return false;
    }
}

constexpr bool if_not_consteval() {
    if !consteval {
        return true;
    }
    else {
        return false;
    }
}



int main() {
    static_assert(if_consteval());
    assert(!if_consteval());

    static_assert(!if_not_consteval());
    assert(if_not_consteval());
}
