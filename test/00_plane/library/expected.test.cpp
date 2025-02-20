#include <print>
#include <iostream>
#include <expected>
#include <iomanip>
#include <string>


// ref: https://cpprefjp.github.io/reference/expected/expected.html

namespace expected {


std::expected<int, std::string> idiv(int a, int b) {
    if(b == 0) { return std::unexpected{ "divide by zero" }; }
    if(a % b != 0) { return std::unexpected{ "out of domain" }; }

    return a / b;
}


void dump_result(const std::expected<int, std::string> &v) {
    if(v) {
        std::println("{}", *v);
    }
    else {
        std::cout << std::quoted(v.error()) << "\n";
    }
}


} // namespace expected


int main() {
    using namespace expected;

    dump_result(idiv(10, 2));
    dump_result(idiv(10, 3));
    dump_result(idiv(10, 0));
}
