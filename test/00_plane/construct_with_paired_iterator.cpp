#include <ranges>
#include <vector>
#include <stack>
#include <queue>

int main() {
    std::vector<int> v = { 10, 20, 30, 40 };

    std::stack<int> s(std::ranges::begin(v), std::ranges::end(v));
    std::queue<int> q(std::ranges::begin(v), std::ranges::end(v));
}
