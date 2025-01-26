#!/bin/bash
set -eu

g++-14 ./Main.cpp -o a.out "${BUILD_FLAGS[@]}"
