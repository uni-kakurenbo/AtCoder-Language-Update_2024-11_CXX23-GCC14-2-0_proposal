#include <coroutine>
#include <print>


#ifndef __clang__


#include <generator>
using std::generator;


#else


#include <utility>
#include <exception>


// ref: https://cpprefjp.github.io/lang/cpp20/coroutines.html

template<class T>
struct generator : std::ranges::view_interface<generator<T>> {
    struct promise_type {
        T _value;

        auto get_return_object() {
            return generator{ *this };
        };

        auto initial_suspend() {
            return std::suspend_always{};
        }

        auto final_suspend() noexcept {
            return std::suspend_always{};
        }

        auto yield_value(auto&& v) {
            this->_value = v;
            return std::suspend_always{};
        }

        void return_void() {}

        void unhandled_exception() { std::terminate(); }
    };

    using _corohandle = std::coroutine_handle<promise_type>;

    struct iterator {
        _corohandle _coro;

        bool _done;

        iterator& operator++() {
            this->_coro.resume();
            _done = this->_coro.done();

            return *this;
        }

        bool operator!=(const iterator& rhs) const {
            return this->_done != rhs._done;
        }

        int operator*() const {
            return this->_coro.promise()._value;
        }
    };

    ~generator() {
      if(this->_coro) this->_coro.destroy();
    }

    generator(generator const&) = delete;

    generator(generator&& rhs) : _coro(std::exchange(rhs._coro, nullptr)) {}

    iterator begin() {
        this->_coro.resume();
        return { this->_coro, this->_coro.done() };
    }

    iterator end() {
        return { {}, true };
    }

  private:
    explicit generator(promise_type& p) : _coro(_corohandle::from_promise(p)) {}

    _corohandle _coro;
};


#endif


template<class T>
generator<T> iota(T end) {
    for(T i = 0; i < end; ++i) {
        co_yield i;
    }
}


int main() {
    for(auto v : iota<int>(10)) std::println("{}", v);
}
