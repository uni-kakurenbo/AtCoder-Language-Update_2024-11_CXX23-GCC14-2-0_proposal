#include <ranges>
#include <print>
#include <experimental/simd>


int A[16], B[16], C[16];


int main() {
    for(const auto i : std::views::iota(0, 16)){
        A[i] = i;
        B[i] = i * 100;
    }

    std::experimental::fixed_size_simd<int,16> a(&A[0], std::experimental::element_aligned), b;
    b.copy_from(&B[0], std::experimental::element_aligned);


#   ifdef __clang__


    auto d = a;


#   else


    auto c = a + b;

    c.copy_to(&C[0], std::experimental::element_aligned);

    for(const auto v : C) std::print("{} ", v);
    std::println();

    std::experimental::native_simd<double> d = 100, e([](int i){ return i * i * i * i; });
    d += std::experimental::sqrt(e);


#   endif


    for(const auto i : std::views::iota(0) | std::views::take(d.size())) std::print("{} ", int(d[i]));
    std::println();
}
