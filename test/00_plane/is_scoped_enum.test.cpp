#include <iostream>
#include <type_traits>


enum unscoped_enum {};
enum class scoped_enum {};


int main() {
    static_assert(!std::is_enum_v<int>);
    static_assert(std::is_enum_v<unscoped_enum>);
    static_assert(std::is_enum_v<scoped_enum>);

    static_assert(!std::is_scoped_enum_v<int>);
    static_assert(!std::is_scoped_enum_v<unscoped_enum>);
    static_assert(std::is_scoped_enum_v<scoped_enum>);
}
