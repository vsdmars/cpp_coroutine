file(
    RELATIVE_PATH relative_path
    "/${cpp_coroutine_INSTALL_CMAKEDIR}"
    "/${CMAKE_INSTALL_BINDIR}/${cpp_coroutine_NAME}"
)

get_filename_component(prefix "${CMAKE_INSTALL_PREFIX}" ABSOLUTE)
set(config_dir "${prefix}/${cpp_coroutine_INSTALL_CMAKEDIR}")
set(config_file "${config_dir}/cpp_coroutineConfig.cmake")

message(STATUS "Installing: ${config_file}")
file(WRITE "${config_file}" "\
get_filename_component(
    _cpp_coroutine_executable
    \"\${CMAKE_CURRENT_LIST_DIR}/${relative_path}\"
    ABSOLUTE
)
set(
    CPP_COROUTINE_EXECUTABLE \"\${_cpp_coroutine_executable}\"
    CACHE FILEPATH \"Path to the cpp_coroutine executable\"
)
")
list(APPEND CMAKE_INSTALL_MANIFEST_FILES "${config_file}")
