#include <cassert>
#include <utility>


int main() {
    int a = 1;
    assert(([b = std::move(a)] mutable { return b; })());

    assert(([] constexpr mutable noexcept -> bool { return true; })());
}
