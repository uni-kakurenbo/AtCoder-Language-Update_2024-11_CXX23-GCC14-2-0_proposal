#include <iostream>
#include <boost/stacktrace.hpp>


namespace boost_stacktrace {


auto a() __attribute__((noinline, noclone));
auto b() __attribute__((noinline, noclone));
auto c() __attribute__((noinline, noclone));
auto d() __attribute__((noinline, noclone));


auto a() {
  return boost::stacktrace::stacktrace();
}

auto b() {
    return a();
}

auto c() {
    return b();
}

auto d() {
    return c();
}


} // namespace boost_stacktrace


int main() {
    using namespace boost_stacktrace;

    std::cout << a() << "\n";
    std::cout << b() << "\n";
    std::cout << c() << "\n";
    std::cout << d() << "\n";
}
