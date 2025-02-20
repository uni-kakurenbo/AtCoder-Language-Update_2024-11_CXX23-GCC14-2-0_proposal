#include <print>


namespace deducing_this {


struct X {
    void f() const& {
        std::println("f");
    }

    void g(this const X& self) {
        std::println("g");

        self.f();
    }
};


} // namespace deducing_this


int main() {
    using namespace deducing_this;

    X{}.g();
}
