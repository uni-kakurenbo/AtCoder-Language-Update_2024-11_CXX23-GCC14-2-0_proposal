struct X {
    void f() const& {}
    void g(this const X& self) {
        self.f();
    }
};

int main() {
    X x;
    x.g();
}
