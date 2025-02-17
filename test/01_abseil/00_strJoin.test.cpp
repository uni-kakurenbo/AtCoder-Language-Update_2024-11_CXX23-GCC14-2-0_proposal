// ref: https://abseil.io/docs/cpp/quickstart-cmake#creating-your-test-code
#include <print>
#include <string>
#include <vector>
#include <absl/strings/str_join.h>

int main() {
  const std::vector<std::string> v = {"foo", "bar", "baz"};
  const auto s = absl::StrJoin(v, "-");

  println("{}", s);
}
