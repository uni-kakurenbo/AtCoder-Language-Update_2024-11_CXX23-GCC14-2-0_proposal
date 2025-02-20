#include <cassert>


template <class T>
constexpr T zero = 0;

template <class T>
constexpr T* zero<T*> = nullptr;


int main() {
    assert(zero<int> == 0);
    assert(zero<int*> == nullptr);
}
