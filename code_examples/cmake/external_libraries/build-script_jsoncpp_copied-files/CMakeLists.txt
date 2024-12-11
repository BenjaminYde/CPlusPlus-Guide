# define project
cmake_minimum_required(VERSION 3.31.0)
project(MyProject CXX)

# variables
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(EXTERN_DIR "${CMAKE_SOURCE_DIR}/extern")
set(EXTERN_INSTALL_DIR "${EXTERN_DIR}/install")

# add executable
add_executable(MyTarget ${SOURCE_DIR}/main.cpp)

# add package: jsoncpp
target_include_directories(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/include")
target_link_directories(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/lib/")
target_link_libraries(MyTarget PRIVATE jsoncpp)

# it is also possible to directly link the file (instead of the above 2 lines):
#target_link_libraries(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/lib/libjsoncpp.a")