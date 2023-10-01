# configure cmake version
cmake_minimum_required(VERSION 3.27 FATAL_ERROR)

# cmake include modules
include(FetchContent)

# configure cmake
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# project
project(Examples
        LANGUAGES "CXX")
        
# add sub directories
add_subdirectory(multithreading)