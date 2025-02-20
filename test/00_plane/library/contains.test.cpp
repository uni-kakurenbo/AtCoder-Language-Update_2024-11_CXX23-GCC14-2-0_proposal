#include <cassert>
#include <string>


int main() {
    std::string_view s = "abc";

    assert(s.contains('b'));
    assert(!s.contains('d'));
}
