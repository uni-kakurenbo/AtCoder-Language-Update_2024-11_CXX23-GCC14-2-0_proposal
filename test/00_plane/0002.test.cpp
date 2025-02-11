#include <coroutine>
#include <print>
#include <generator>

template<class T>
std::generator<T> iota(T end) {
    for(T i = 0; i < end; ++i) {
        co_yield i;
    }
}

int main() {
    for(auto v : iota<int>(10)) std::println("{}", v);
}
