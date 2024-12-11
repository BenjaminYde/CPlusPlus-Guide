# define project
cmake_minimum_required(VERSION 3.20.0)
project(MyProject CXX)

# variables
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(EXTERN_DIR "${CMAKE_SOURCE_DIR}/extern")
set(EXTERN_INSTALL_DIR "${EXTERN_DIR}/install")

# add executable
add_executable(MyTarget ${SOURCE_DIR}/main.cpp)

#include cmake modules
include(ExternalProject)

# get package: json cpp
ExternalProject_Add(external_jsoncpp
  GIT_REPOSITORY https://github.com/open-source-parsers/jsoncpp.git
  GIT_TAG 1.9.6
  UPDATE_COMMAND ""
  PREFIX "${EXTERN_DIR}/jsoncpp"
  INSTALL_DIR "${EXTERN_INSTALL_DIR}/jsoncpp"
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    -DJSONCPP_WITH_TESTS=OFF
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_STATIC_LIBS=ON
)

# get cached data
ExternalProject_Get_Property(external_jsoncpp INSTALL_DIR)

# add package: jsoncpp
add_dependencies(MyTarget external_jsoncpp)
target_include_directories(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/include")
target_link_directories(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/lib/")
target_link_libraries(MyTarget PRIVATE jsoncpp)

# it is also possible to directly link the file (instead of the above 2 lines):
#target_link_libraries(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/lib/libjsoncpp.a")