#include "lib.hpp"

auto main() -> int
{
  auto const lib = library {};

  return lib.name == "cpp_coroutine" ? 0 : 1;
}
