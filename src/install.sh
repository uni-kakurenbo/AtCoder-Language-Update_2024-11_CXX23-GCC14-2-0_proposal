#!/bin/bash
set -eu

sudo mkdir -p /tmp/ac_install/
sudo mkdir -p /opt/ac_install/

cd /tmp/ac_install/

### Compiler
if [[ ! -v AC_VARIANT ]] || [[ "${AC_VARIANT}" == "gcc" ]]; then
    echo "::group::GCC"

    sudo apt-get install -y "g++-14=${VERSION}"

    C_COMPILER="gcc-14"
    CXX_COMPILER="gcc++-14"
else
    echo "::group::Clang"

    sudo apt-get install -y lsb-release software-properties-common gnupg
    sudo wget https://apt.llvm.org/llvm.sh

    chmod +x ./llvm.sh

    sudo ./llvm.sh 19
    sudo apt-get install -y libc++-19-dev="${VERSION}"
    sudo apt-get purge -y --auto-remove lsb-release software-properties-common gnupg

    C_COMPILER="clang-19"
    CXX_COMPILER="clang++-19"
fi

echo "::endgroup::"

### Libraries
echo "::group::tools"
sudo apt-get install -y git cmake ninja-build pigz pbzip2
echo "::endgroup::"

CMAKE_ENVIRONMENT=(
    -G "Ninja"

    -DCFLAGS:STRING="-w"

    -DCMAKE_C_COMPILER:STRING="${C_COMPILER}"
    -DCMAKE_CXX_COMPILER:STRING="${CXX_COMPILER}"

    -DCMAKE_INSTALL_MESSAGE:STRING="NEVER"
)

BOOST_BUILDER_CONFIG="using gcc : : ${CXX_COMPILER} ;"

if ccache -v; then
    echo "ccache: enabled"

    CMAKE_ENVIRONMENT+=(
        -DCMAKE_C_COMPILER_LAUNCHER:STRING="ccache"
        -DCMAKE_CXX_COMPILER_LAUNCHER:STRING="ccache"
    )

    BOOST_BUILDER_CONFIG="using gcc : : ccache ${CXX_COMPILER} ;"
fi

export CMAKE_ENVIRONMENT
export BOOST_BUILDER_CONFIG

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

    sudo apt-get purge -y --auto-remove git cmake ninja-build pigz pbzip2

    echo "::endgroup::"
fi
