#ifndef __clang


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <mdspan>


// ref: https://cpprefjp.github.io/reference/mdspan/mdspan.html

int main() {
    using extentes_2x3 = std::extents<size_t, 2, 3>;
    const double arr[] = {1, 2, 3, 4, 5, 6};

    std::mdspan<double, extentes_2x3> mat{arr};

    for(size_t i = 0; i < mat.extent(0); ++i) {
        for(size_t j = 0; j < mat.extent(1); ++j) {
            std::print("{} ", mat[i, j]);
        }

        std::println();
    }
}


#endif
