#ifdef __GNUC__


#pragma message("skipped")

int main() {}


#else


#include <flat_map>
#include <iostream>
#include <string>



int main() {
    std::flat_map<std::string, int> fm = {
        { "0", 0 },
        { "1", 1 },
        { "2", 2 },
    };


    for(const auto &[key, value] : fm) {
        assert(std::stoi(key) == value);
    }
}


#endif
