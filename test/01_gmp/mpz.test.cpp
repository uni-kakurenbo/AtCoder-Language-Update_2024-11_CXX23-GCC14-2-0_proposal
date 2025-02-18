#include <time.h>
#include <gmp.h>

int main() {
    mpz_t a;
    mpz_init(a);

    gmp_randstate_t state;
    gmp_randinit_default(state);

    time_t rtime;
    time(&rtime);
    gmp_randseed_ui(state, rtime);

    mpz_urandomb(a, state, 256);

    gmp_printf("%Zx\n", a);

    mpz_clear(a);
    gmp_randclear(state);
}
