#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


#include <print>
#include <LightGBM/c_api.h>

int main() {
    std::println("{}", LGBM_SetMaxThreads(2));
}


#endif
