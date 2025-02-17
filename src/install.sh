#!/bin/bash
set -eu

sudo mkdir -p /tmp/ac_install/
sudo mkdir -p /opt/ac_install/

cd /tmp/ac_install/

### Compiler
if [[ "${AC_VARIANT:-gcc}" == "gcc" ]]; then
    ./sub-installer/compiler/gcc.sh

    CC="gcc-14"
    CXX="g++-14"
else
    ./sub-installer/compiler/clang.sh

    CC="clang-19"
    CXX="clang++-19"
fi

### Libraries
echo "::group::tools"
sudo apt-get install -y git cmake ninja-build pigz pbzip2
echo "::endgroup::"

CMAKE_ENVIRONMENT=(
    -G "Ninja"

    -DCFLAGS:STRING="-w"

    -DCMAKE_C_COMPILER:STRING="${CC}"
    -DCMAKE_CXX_COMPILER:STRING="${CXX}"

    -DCMAKE_INSTALL_MESSAGE:STRING="NEVER"
)

BOOST_BUILDER_CONFIG="using gcc : : ${CXX} ;"

if ccache -v; then
    echo "ccache: enabled"

    export CCACHE_ENABLED=1

    CMAKE_ENVIRONMENT+=(
        -DCMAKE_C_COMPILER_LAUNCHER:STRING="ccache"
        -DCMAKE_CXX_COMPILER_LAUNCHER:STRING="ccache"
    )

    BOOST_BUILDER_CONFIG="using ${AC_VARIANT} : : ccache ${CXX} ;"
fi

export CMAKE_ENVIRONMENT
export BOOST_BUILDER_CONFIG

./sub-installer/library/abseil.sh
./sub-installer/library/ac-library.sh
./sub-installer/library/boost.sh
./sub-installer/library/eigen.sh
./sub-installer/library/gmp.sh
./sub-installer/library/libtorch.sh
./sub-installer/library/light-gbm.sh
./sub-installer/library/or-tools.sh
./sub-installer/library/range-v3.sh
./sub-installer/library/unordered_dense.sh
./sub-installer/library/z3.sh

if [ -v ATCODER ]; then
    echo "::group::finalize"

    find /opt/ac_install/ \
        -name cmake -or -name pkgconfig -or -name bin -or -name share \
        -type d -print0 |
        xargs -0 sudo rm -rf

    sudo apt-get purge -y --auto-remove git cmake ninja-build pigz pbzip2

    echo "::endgroup::"
fi
