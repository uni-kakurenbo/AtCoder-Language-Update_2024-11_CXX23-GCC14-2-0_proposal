#!/bin/bash
set -eu

if [[ ! -v AC_VARIANT ]] || [[ "${AC_VARIANT}" = "gcc" ]]; then
    g++-14 ./Main.cpp -o a.out "${BUILD_FLAGS[@]}"
else
    clang++-19 ./Main.cpp -o a.out "${BUILD_FLAGS[@]}"
fi
