#include <cassert>
#include <algorithm>
#include <vector>

int main() {
    std::vector<int> v{ 0, 1, 2, 3 };
    assert(std::max(1uz, v.size()) == 4uz);
}
