#!/bin/bash

# cd in jscon cpp project
SCRIPT_DIR="$(dirname "$0")"
PROJECT_DIR=$SCRIPT_DIR/..
cd $PROJECT_DIR/extern/jsoncpp

# configure jsoncpp
rm -rf build
mkdir build

cmake \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_STATIC_LIBS=ON \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=../install/jsoncpp \
    -S . \
    -B build

# build and install
cmake --build build --target install --parallel 8