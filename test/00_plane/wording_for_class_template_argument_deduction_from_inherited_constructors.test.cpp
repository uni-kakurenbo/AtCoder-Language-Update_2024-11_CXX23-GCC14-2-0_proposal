#include <concepts>


#ifdef __clang__


#pragma message("skipped")

int main() {}


#else


template<class T, class U, class V>
struct basic_class_template {
    using value_type = T;
    basic_class_template(T, U, V) {};
};


template<class T, class U>
struct derived_class_template : basic_class_template<U, T, int> {
   using basic_class_template<U, T, int>::basic_class_template;
};


int main() {
    static_assert(
        std::same_as<
            decltype(derived_class_template(true, 'a', 1))::value_type,
            bool
        >
    );
}


#endif
