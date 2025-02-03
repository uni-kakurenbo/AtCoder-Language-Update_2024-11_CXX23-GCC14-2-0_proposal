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

    -DCMAKE_INSTALL_MESSAGE:STRING="NEVER"
)

if ccache -v; then
    echo "ccache: enabled"

    export BOOST_BUILDER_CONFIG="using gcc : : ccache g++-14 ;"

    CMAKE_ENVIRONMENT+=(
        -DCMAKE_C_COMPILER_LAUNCHER:STRING="ccache"
        -DCMAKE_CXX_COMPILER_LAUNCHER:STRING="ccache"
    )
fi

export CMAKE_ENVIRONMENT

./sub-installers/abseil.sh
./sub-installers/ac-library.sh
./sub-installers/boost.sh
./sub-installers/eigen.sh
./sub-installers/gmp.sh
./sub-installers/libtorch.sh
./sub-installers/light-gbm.sh
./sub-installers/or-tools.sh
./sub-installers/range-v3.sh
./sub-installers/unordered_dense.sh
./sub-installers/z3.sh

if [ -v ATCODER ]; then
    echo "::group::finalize"

    find /opt/ac_install/ \
        -name cmake -or -name pkgconfig -or -name bin -or -name share \
        -type d -print0 |
        xargs -0 sudo rm -rf

    sudo apt-get remove -y --auto-remove git cmake ninja-build pigz pbzip2

    echo "::endgroup::"
fi
