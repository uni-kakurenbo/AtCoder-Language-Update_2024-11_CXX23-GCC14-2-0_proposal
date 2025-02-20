#include <cassert>


namespace portable_assumptions {


int f(int x) {
    [[assume(x-- == 0)]];

    return x;
}


} // namespace portable_assumptions


int main() {
    using namespace portable_assumptions;

    assert(f(1));
}
