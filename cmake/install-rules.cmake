include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package cpp_coroutine)

install(
    TARGETS cpp_coroutine_exe
    RUNTIME COMPONENT cpp_coroutine_Runtime
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    cpp_coroutine_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(cpp_coroutine_INSTALL_CMAKEDIR)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${cpp_coroutine_INSTALL_CMAKEDIR}"
    COMPONENT cpp_coroutine_Development
)

# Export variables for the install script to use
install(CODE "
set(cpp_coroutine_NAME [[$<TARGET_FILE_NAME:cpp_coroutine_exe>]])
set(cpp_coroutine_INSTALL_CMAKEDIR [[${cpp_coroutine_INSTALL_CMAKEDIR}]])
set(CMAKE_INSTALL_BINDIR [[${CMAKE_INSTALL_BINDIR}]])
" COMPONENT cpp_coroutine_Development)

install(
    SCRIPT cmake/install-script.cmake
    COMPONENT cpp_coroutine_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
