#include <iostream>
#include <utility>

enum class char_enum : char {
    element
};

enum class default_enum {
    element
};

int main() {
    static_assert(std::same_as<decltype(std::to_underlying(char_enum::element)), char>);
    static_assert(std::same_as<decltype(std::to_underlying(default_enum::element)), int>);
}
