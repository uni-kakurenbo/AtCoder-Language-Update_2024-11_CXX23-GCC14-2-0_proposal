#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <omp.h>

int main() {
    std::println("max threads: {}", omp_get_max_threads());
}


#endif
