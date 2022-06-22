# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(cpp_coroutineTests LANGUAGES CXX)

# ---- Tests ----

add_executable(cpp_coroutine_test source/cpp_coroutine_test.cpp)
target_link_libraries(cpp_coroutine_test PRIVATE cpp_coroutine_lib)
target_compile_features(cpp_coroutine_test PRIVATE cxx_std_20)

add_test(NAME cpp_coroutine_test COMMAND cpp_coroutine_test)

# ---- End-of-file commands ----

add_folders(Test)
