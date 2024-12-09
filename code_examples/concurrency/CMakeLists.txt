# configure cmake version
cmake_minimum_required(VERSION 3.27 FATAL_ERROR)

# cmake include modules
include(FetchContent)

# project
project(Examples.Concurrency
        LANGUAGES "CXX")

# create target
set(TARGET multithreading)
add_executable(${TARGET} main.cpp)