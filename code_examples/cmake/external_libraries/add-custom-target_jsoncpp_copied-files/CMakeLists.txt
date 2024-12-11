# define project
cmake_minimum_required(VERSION 3.31.0)
project(MyProject CXX)

# variables
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(EXTERN_DIR "${CMAKE_SOURCE_DIR}/extern")
set(EXTERN_INSTALL_DIR "${EXTERN_DIR}/install")

# add executable
add_executable(MyTarget ${SOURCE_DIR}/main.cpp)

# add external jsoncpp build step
add_custom_target(external_jsoncpp ALL
    COMMAND cmake -S . -B build
                  -DCMAKE_BUILD_TYPE=Release 
                  -DBUILD_STATIC_LIBS=ON 
                  -DBUILD_SHARED_LIBS=OFF
                  -DCMAKE_INSTALL_PREFIX="${EXTERN_INSTALL_DIR}/jsoncpp"
    COMMAND cmake --build build --target install --parallel 8
    WORKING_DIRECTORY "${EXTERN_DIR}/jsoncpp"
    COMMENT "Building and installing jsoncpp"
)

# make MyTarget depend on the external_jsoncpp target
add_dependencies(MyTarget external_jsoncpp)
target_include_directories(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/include")
target_link_directories(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/lib/")
target_link_libraries(MyTarget PRIVATE jsoncpp)

# it is also possible to directly link the file (instead of the above 2 lines):
#target_link_libraries(MyTarget PRIVATE "${EXTERN_INSTALL_DIR}/jsoncpp/lib/libjsoncpp.a")