#!/bin/bash

# variables
SCRIPT_DIR="$(dirname "$0")"
PROJECT_DIR=$SCRIPT_DIR/..

# go in project directory
cd $PROJECT_DIR

# clean files
rm -rf build || true

# configure
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -G Ninja

# build
cmake --build build --target MyTarget --parallel 8

# execute
./build/MyTarget