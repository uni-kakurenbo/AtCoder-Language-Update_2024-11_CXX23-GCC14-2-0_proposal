#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <algorithm>
#include <functional>
#include <print>
#include <ranges>
#include <vector>


// ref: https://cpprefjp.github.io/reference/algorithm/ranges_fold_left.html

int main() {
    using namespace std::ranges;

    range auto rng = views::iota('a', 'g');

    const std::string init = "init";

    auto op_left = [](std::string acc, char elem) {
        acc += " -> ";
        acc += elem;
        return acc;
    };

    auto op_right = [op_left](char elem, std::string acc) {
        return op_left(std::move(acc), elem);
    };

    auto resl = fold_left(rng, init, op_left);
    auto resr = fold_right(rng, init, op_right);

    std::println("{:s}", resl);
    std::println("{:s}", resr);
}


#endif
