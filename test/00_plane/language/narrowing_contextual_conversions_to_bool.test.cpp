constexpr int N = 1;

int main() {
    if constexpr(N) {}
    if constexpr(N % 4) {}

    static_assert(N);
    static_assert(N % 4);
}
