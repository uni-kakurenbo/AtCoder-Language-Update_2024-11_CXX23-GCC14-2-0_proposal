#!/bin/bash
set -eu

### GCC
echo "::group::GCC"
sudo apt-get install -y "g++-14=${VERSION}"
echo "::endgroup::"

### Libraries
echo "::group::tools"
sudo apt-get install -y git cmake ninja-build pigz pbzip2
echo "::endgroup::"

sudo mkdir -p /tmp/ac_install/
sudo mkdir -p /opt/ac_install/

CMAKE_ENVIRONMENT=(
    -G "Ninja"
    -DCFLAGS:STRING="-w"
    -DCMAKE_CXX_COMPILER:STRING="g++-14"
)

if ccache -v; then
    echo "ccache: enabled"

    CMAKE_ENVIRONMENT+=(
        -DCMAKE_C_COMPILER_LAUNCHER:STRING="ccache"
        -DCMAKE_CXX_COMPILER_LAUNCHER:STRING="ccache"
    )
fi

./sub-installers/abseil.sh
./sub-installers/AC-Library.sh
./sub-installers/Boost.sh
./sub-installers/Eigen.sh
./sub-installers/GMP.sh
./sub-installers/libtorch.sh
./sub-installers/LightGBM.sh
./sub-installers/or-tools.sh
./sub-installers/range-v3.sh
./sub-installers/unordered_dense.sh
./sub-installers/Z3.sh

echo "::group::finalize"
find /opt/ -name cmake -or -name pkgconfig -or -name bin -or -name share -type d -print0 | xargs -0 sudo rm -rf
sudo apt-get remove -y --auto-remove git cmake ninja-build pigz pbzip2
echo "::endgroup::"
