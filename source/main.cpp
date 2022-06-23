#include <iostream>
#include <string>

#include "lib.hpp"

auto main() -> int {
  auto const lib = Library{};
  auto const message = lib.name + "in action";
  std::cout << message << '\n';
  return 0;
}
