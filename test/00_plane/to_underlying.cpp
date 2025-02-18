#include <iostream>
#include <utility>

enum class char_enum : char {
    Elem
};

enum class default_enum {
    Elem
};

int main() {
    static_assert(std::same_as<decltype(std::to_underlying(char_enum::Elem)), char>);
    static_assert(std::same_as<decltype(std::to_underlying(default_enum::Elem)), int>);
}
