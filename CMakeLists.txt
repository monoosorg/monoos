cmake_minimum_required(VERSION 3.10)

if(NOT ARCH)
    message(FATAL_ERROR "Target architecture (ARCH) is not defined. Please, choose one of: arm, arm64")
endif()

include(CMakeDependentOption)

# CMAKE_CROSSCOMPILING and MSVC_IDE are not set until project() is called, so let's test this instead
if ((DEFINED CMAKE_TOOLCHAIN_FILE) AND (CMAKE_GENERATOR MATCHES "Visual Studio.*"))
    # Do not use MSVC_RUNTIME_LIBRARY target property. We use our own flags instead
    message(WARNING "Setting policy CMP0091 to OLD behaviour")
    cmake_policy(SET CMP0091 OLD)
endif()

project(MONOOS)

# check that the ARCH (target architecture) variable is defined
if(NOT ARCH)
    message(FATAL_ERROR "Target architecture (ARCH) is not defined. Please, choose one of: arm, arm64")
endif()
# Now the ARCH variable will be in lowercase.
# It is needed because STREQUAL comparison
# is case-sensitive.
# See http://cmake.3232098.n2.nabble.com/Case-insensitive-string-compare-td7580269.html
# for more information.
string(TOLOWER ${ARCH} ARCH)

# set possible values for cmake GUI
set_property(CACHE ARCH PROPERTY STRINGS "arm" "arm64")

message(${ARCH})
message(${ENABLE_CCACHE})
message(${MONOOS_SOURCE_DIR})
# message(${BUILD_TOOLS_FLAG})

# include(toolchain-gcc.cmake)

# Versioning
# include(sdk/include/reactos/version.cmake)

# Compile options
# include(sdk/cmake/config.cmake)

# Compiler flags handling
# include(sdk/cmake/compilerflags.cmake)

add_subdirectory(kernel)


