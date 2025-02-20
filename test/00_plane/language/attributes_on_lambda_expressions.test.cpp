#include <cassert>


int main() {
    assert(([] [[nodiscard]] { return true; })());
}
