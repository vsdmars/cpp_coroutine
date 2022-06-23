#pragma once

#include <coroutine>
#include <exception>
#include <string>

/**
 * @brief The core implementation of the executable
 *
 * This class makes up the library part of the executable, which means that the
 * main logic is implemented here. This kind of separation makes it easy to
 * test the implementation for the executable, because the logic is nicely
 * separated from the command-line logic implemented in the main function.
 */
struct Library {
  /**
   * @brief Simply initializes the name member to the name of the project
   */
  Library();

  std::string name;
};

// ---- Coroutine try out ----

// 1. coroutine return type, it has to have promise_type defined inside
// 2. await type
// 3. promise_type for std::coroutine_handle

template <typename R> struct MyPromise {
  using HandleType = std::coroutine_handle<MyPromise>;

  // get_return_object returns object to coroutine caller
  auto get_return_object() -> R { return R(HandleType::from_promise(*this)); }

  // await_transform convert co_await expr to awaitable object
  template <typename T> auto await_transform(T&& expr) { return std::forward<T>(expr); }

  // initial_suspend called during first suspension point
  std::suspend_always initial_suspend() noexcept { return {}; }

  // final_suspend called during last suspension point
  std::suspend_always final_suspend() noexcept { return {}; }

  // return_void is called with co_return
  void return_void() {}

  // return_value called with co_return expr
  template <typename T> auto return_value(T&& expr) { return std::forward<T>(expr); }

  // unhandled_exception called if Promise throws exception
  void unhandled_exception() { exception_ = std::current_exception(); }

  // yield_value yields co_yield expr's result
  template <typename T> std::suspend_always yield_value(T&& expr) { return {}; }

private:
  std::exception_ptr exception_;
};

template <typename R, template <typename> class PROMISE> struct PromiseBase {
  using promise_type = PROMISE<R>;
};

template <template <typename> class PROMISE>
class Return : public PromiseBase<Return<PROMISE>, PROMISE> {
private:
  using handle_type = std::coroutine_handle<PROMISE<Return>>;

public:
  explicit Return(handle_type handle) : ht_(handle) {}

private:
  handle_type ht_;
};

auto awaitCo = []() {

};
