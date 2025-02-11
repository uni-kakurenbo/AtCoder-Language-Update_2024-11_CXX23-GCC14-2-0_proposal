#include <print>
#include <LightGBM/c_api.h>

int main() {
    std::println("{}", LGBM_SetMaxThreads(2));
}
