#include <print>

struct X {
    void f() const& {
        std::println("f");
    }

    void g(this const X& self) {
        std::println("g");

        self.f();
    }
};

int main() {
    X x;
    x.g();
}
