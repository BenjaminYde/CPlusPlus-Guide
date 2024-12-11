# define project
cmake_minimum_required(VERSION 3.31.0)
project(MyProject CXX)

# variables
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(EXTERN_DIR "${CMAKE_SOURCE_DIR}/extern")

# add executable
add_executable(MyTarget ${SOURCE_DIR}/main.cpp)

#include cmake modules
include(FetchContent)

# package - declare: json cpp
FetchContent_Declare(
  external_jsoncpp
  SOURCE_DIR "${EXTERN_DIR}/jsoncpp"
)

set(JSONCPP_WITH_TESTS OFF)
set(BUILD_SHARED_LIBS OFF)
set(DBUILD_STATIC_LIBS ON)

# package - make available: json cpp
FetchContent_MakeAvailable(external_jsoncpp)

# package - link libraries
target_link_libraries(MyTarget PRIVATE jsoncpp_static)