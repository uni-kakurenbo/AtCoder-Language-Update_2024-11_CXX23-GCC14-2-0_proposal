#include <cassert>


int main() {
    const char8_t* a = u8"\u0100\u0300";
    const char8_t* b = u8"\N{LATIN CAPITAL LETTER A WITH MACRON}\N{COMBINING GRAVE ACCENT}";

    assert(reinterpret_cast<const char*>(a) == reinterpret_cast<const char*>(b));
}
