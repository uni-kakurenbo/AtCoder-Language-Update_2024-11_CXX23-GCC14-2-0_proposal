#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <cassert>
#include <iostream>
#include <string_view>
#include <spanstream>
#include <sstream>


// ref: https://cppmap.github.io/standardization/cpp23/#stdstringstream-stdspan-stdspanstream-p0448r4

int main() {
    const char input[] = "0 1 2";

    std::ispanstream is{ input };
    int a, b, c;
    is >> a >> b >> c;

    char buffer[30]{};

    std::ospanstream os{ buffer };
    os << (a * 100) << (b * 100) << (c * 100);

    assert(std::string_view{ os.span() } == "0100200");
}


#endif
