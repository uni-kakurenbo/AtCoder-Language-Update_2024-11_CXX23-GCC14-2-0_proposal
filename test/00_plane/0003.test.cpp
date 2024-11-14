#include <print>
#include <stacktrace>

auto a() __attribute__((noinline, noclone));
auto b() __attribute__((noinline, noclone));
auto c() __attribute__((noinline, noclone));
auto d() __attribute__((noinline, noclone));

auto a() {
  return std::stacktrace::current();
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

signed main() {
    std::println("{}", a());
    std::println("{}", b());
    std::println("{}", c());
    std::println("{}", d());
}
