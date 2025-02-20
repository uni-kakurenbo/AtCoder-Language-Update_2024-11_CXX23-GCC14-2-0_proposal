#include <cassert>


struct statically_invokable {
  static bool operator()(int x) {
    return x > 0;
  }
};


int main() {
    auto f = []() static { return 1; };
    assert(statically_invokable::operator()(f()));
}
