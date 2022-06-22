cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    cpp_coroutine
    VERSION 0.1.0
    DESCRIPTION "c++20 coroutine example"
    HOMEPAGE_URL "vsdmars.blogspot.com"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    cpp_coroutine_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    cpp_coroutine_lib ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(cpp_coroutine_lib PUBLIC cxx_std_20)

# ---- Declare executable ----

add_executable(cpp_coroutine_exe source/main.cpp)
add_executable(cpp_coroutine::exe ALIAS cpp_coroutine_exe)

set_target_properties(
    cpp_coroutine_exe PROPERTIES
    OUTPUT_NAME cpp_coroutine
    EXPORT_NAME exe
)

target_compile_features(cpp_coroutine_exe PRIVATE cxx_std_20)

target_link_libraries(cpp_coroutine_exe PRIVATE cpp_coroutine_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT cpp_coroutine_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of cpp_coroutine"
  )
endif()

include(cmake/dev-mode.cmake)
