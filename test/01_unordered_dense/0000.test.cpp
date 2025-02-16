#include <print>
#include <ankerl/unordered_dense.h>

int main() {
    ankerl::unordered_dense::map<int, std::string> map;

    map[31415] = "3.1415";
    map[27182] = "2.7182";

    for(const auto& [key, val] : map) {
        println("{}: {}", key, val);
    }
}
