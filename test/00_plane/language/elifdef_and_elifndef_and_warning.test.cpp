#ifdef SOMETHING

#error unreachable

#elifndef __GNUC__

#error unreachable

#elifdef __cplusplus


#warning reachable

int main() {}


#else

#error unreachable

#endif
