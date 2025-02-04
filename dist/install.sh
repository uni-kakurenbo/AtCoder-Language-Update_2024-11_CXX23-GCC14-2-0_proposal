#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################

# shellcheck disable=all
PARALLEL="$(nproc)"

BUILD_FLAGS=(
    "-std=gnu++23"
    "-w"
    "-lstdc++exp"
)

VERSION="14.2.0-4ubuntu2~24.04"

set -eu

echo "::group::GCC"
sudo apt-get install -y "g++-14=${VERSION}"
echo "::endgroup::"

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

BOOST_BUILDER_CONFIG="using gcc : : g++-14 ;"

if ccache -v; then
    echo "ccache: enabled"

    CMAKE_ENVIRONMENT+=(
        -DCMAKE_C_COMPILER_LAUNCHER:STRING="ccache"
        -DCMAKE_CXX_COMPILER_LAUNCHER:STRING="ccache"
    )

    BOOST_BUILDER_CONFIG="using gcc : : ccache g++-14 ;"
fi

export CMAKE_ENVIRONMENT
export BOOST_BUILDER_CONFIG


# abseil
(
VERSION="20240722.0"

set +u
if [[ ${AC_NO_BUILD_abseil} && ${AC_NO_BUILD_or_tools} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::abseil"

sudo mkdir -p ./abseil/

sudo wget -q "https://github.com/abseil/abseil-cpp/releases/download/${VERSION}/abseil-cpp-${VERSION}.tar.gz" -O ./abseil.tar.gz
sudo tar -I pigz -xf ./abseil.tar.gz -C ./abseil/ --strip-components 1

cd ./abseil/

sudo mkdir -p ./build/ && cd ./build/

CMAKE_ARGUMENTS=(
    "${CMAKE_ENVIRONMENT[@]}"
    -DABSL_ENABLE_INSTALL:BOOL=ON
    -DABSL_PROPAGATE_CXX_STD:BOOL=ON
    -DABSL_USE_SYSTEM_INCLUDES:BOOL=ON
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/
    -DCMAKE_CXX_FLAGS:STRING="-fPIC ${BUILD_FLAGS[*]}"
)

if [[ -v RUN_TEST ]] && [[ "${RUN_TEST}" = "true" ]]; then
    sudo cmake -DABSL_BUILD_TESTING=ON -DABSL_USE_GOOGLETEST_HEAD=ON "${CMAKE_ARGUMENTS[@]}" ../

    sudo make "-j${PARALLEL}"
    sudo ctest --parallel "${PARALLEL}"
else
    sudo cmake "${CMAKE_ARGUMENTS[@]}" ../
fi

sudo cmake --build ./ --target install

echo "::endgroup::"
)


# ac-library
(
VERSION="1.5.1"

set +u
if [[ ${AC_NO_BUILD_ac_library} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::AC Library"

sudo wget -q "https://github.com/atcoder/ac-library/releases/download/v${VERSION}/ac-library.zip" -O ./ac-library.zip
sudo unzip -oq ./ac-library.zip -d /opt/ac_install/include/

echo "::endgroup::"
)


# boost
(
VERSION="1.86.0"

set +u
if [[ ${AC_NO_BUILD_boost} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::boost"

sudo mkdir -p ./boost/

sudo wget -q "https://archives.boost.io/release/${VERSION}/source/boost_${VERSION//./_}.tar.bz2" -O ./boost.tar.bz2
sudo tar -I pbzip2 -xf ./boost.tar.bz2 -C ./boost/ --strip-components 1

cd ./boost/

if [[ -v BOOST_BUILDER_CONFIG ]]; then
    echo "${BOOST_BUILDER_CONFIG}" | sudo tee -a ./user-config.jam
else
    sudo touch ./user-config.jam
fi

sudo ./bootstrap.sh \
    --with-toolset=gcc \
    --without-libraries=mpi,graph_parallel \
    --prefix=/opt/ac_install/

sudo ./b2 \
    toolset=gcc \
    link=static \
    threading=single \
    variant=release \
    cflags="-w" \
    cxxflags="${BUILD_FLAGS[*]}" \
    --user-config="./user-config.jam" \
    -j"${PARALLEL}" -d0 \
    install

echo "::endgroup::"
)


# eigen
(
VERSION="3.4.0-4"

set +u
if [[ ${AC_NO_BUILD_eigen} && ${AC_NO_BUILD_light_gbm} && ${AC_NO_BUILD_or_tools} ]]; then exit 0; fi
set -eu

echo "::group::Eigen3"

sudo apt-get install -y "libeigen3-dev=${VERSION}"

sudo mkdir -p /opt/ac_install/include/
sudo mkdir -p /opt/ac_install/cmake/

sudo cp -Trf /usr/include/eigen3/ /opt/ac_install/include/

# copy and patch cmake files to build OR-Tools.
sudo cp -f \
    /usr/share/eigen3/cmake/Eigen3Targets.cmake \
    /usr/share/eigen3/cmake/Eigen3Config.cmake \
    /opt/ac_install/cmake/

sudo sed -i \
    -e 's/include\/eigen3/opt\/ac_install\/include\//g' \
    /opt/ac_install/cmake/Eigen3Targets.cmake

sudo apt-get remove -y libeigen3-dev

echo "::endgroup::"
)


# gmp
(
VERSION="2:6.3.0+dfsg-2ubuntu6.1"

set +u
if [[ ${AC_NO_BUILD_gmp} ]]; then exit 0; fi
set -eu

echo "::group::gmp"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
)


# libtorch
(
VERSION="2.5.1"

set +u
if [[ ${AC_NO_BUILD_libtorch} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::LibTorch"

sudo wget -q "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-${VERSION}%2Bcpu.zip" -O ./libtorch.zip
sudo unzip -oq ./libtorch.zip -d ./

sudo mkdir -p /opt/ac_install/include/
sudo mkdir -p /opt/ac_install/lib/

# remove protobuf, which or-tools has as its dependencies.
sudo rm -f ./libtorch/lib/libprotobuf.a
sudo rm -f ./libtorch/lib/libprotobuf-lite.a
sudo rm -f ./libtorch/lib/libprotoc.a

sudo cp -Trf ./libtorch/include/ /opt/ac_install/include/
sudo cp -Trf ./libtorch/lib/ /opt/ac_install/lib/

echo "::endgroup::"
)


# light-gbm
(
VERSION="4.5.0"

set +u
if [[ ${AC_NO_BUILD_light_gbm} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::LightGBM"

if [ -d ./light-gbm/ ]; then
    sudo rm -rf ./light-gbm/
fi

sudo mkdir -p ./light-gbm/

sudo wget -q "https://github.com/microsoft/LightGBM/releases/download/v${VERSION}/lightgbm-${VERSION}.tar.gz" -O ./light-gbm.tar.gz
sudo tar -I pigz -xf ./light-gbm.tar.gz -C ./light-gbm/ --strip-components 1

cd ./light-gbm/

sudo rm -rf ./lightgbm/
sudo rm -rf ./external_libs/eigen/

sudo mkdir -p ./build/ && cd ./build/

sudo cmake "${CMAKE_ENVIRONMENT[@]}" \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/ \
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]} -I/opt/ac_install/include/" \
    ../

sudo cmake --build ./ --target install

echo "::endgroup::"
)


# or-tools
(
VERSION="9.11"

set +u
if [[ ${AC_NO_BUILD_or_tools} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::OR-Tools"

sudo mkdir -p ./or-tools/

sudo wget -q "https://github.com/google/or-tools/archive/refs/tags/v${VERSION}.tar.gz" -O ./or-tools.tar.gz
sudo tar -I pigz -xf ./or-tools.tar.gz -C ./or-tools/ --strip-components 1

cd ./or-tools/

BUILD_TESTING=OFF

if [[ -v RUN_TEST ]] && [[ "${RUN_TEST}" = "true" ]]; then
    BUILD_TESTING=ON
fi

sudo mkdir -p ./build/ && cd ./build/

sudo cmake "${CMAKE_ENVIRONMENT[@]}" \
    -DBUILD_ZLIB:BOOL=ON -DBUILD_Protobuf:BOOL=ON -DBUILD_re2:BOOL=ON \
    -DUSE_COINOR:BOOL=ON -DBUILD_CoinUtils:BOOL=ON -DBUILD_Osi:BOOL=ON -DBUILD_Clp:BOOL=ON -DBUILD_Cgl:BOOL=ON -DBUILD_Cbc:BOOL=ON \
    -DUSE_GLPK:BOOL=ON -DBUILD_GLPK:BOOL=ON \
    -DUSE_HIGHS:BOOL=ON -DBUILD_HIGHS:BOOL=ON \
    -DUSE_SCIP:BOOL=ON -DBUILD_SCIP:BOOL=ON \
    -DBUILD_SAMPLES:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF \
    -DBUILD_TESTING:BOOL="${BUILD_TESTING}" \
    -DCMAKE_PREFIX_PATH:PATH=/opt/ac_install/ \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/ \
    -DBUILD_SHARED_LIBS:BOOL=OFF \
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]}" \
    ../

sudo cmake --build ./ --config Release --target install

if [[ -v RUN_TEST ]] && [[ "${RUN_TEST}" = "true" ]]; then
    sudo cmake --build ./ --config Release --target test --parallel "${PARALLEL}"
fi

echo "::endgroup::"
)


# range-v3
(
VERSION="0.12.0"

set +u
if [[ ${AC_NO_BUILD_range_v3} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::range-v3"

sudo mkdir -p ./range-v3/

sudo wget -q "https://github.com/ericniebler/range-v3/archive/refs/tags/${VERSION}.tar.gz" -O ./range-v3.tar.gz
sudo tar -I pigz -xf ./range-v3.tar.gz -C ./range-v3/ --strip-components 1

sudo mkdir -p /opt/ac_install/include/

sudo cp -Trf ./range-v3/include/ /opt/ac_install/include/

echo "::endgroup::"
)


# unordered_dense
(
VERSION="4.4.0"

set +u
if [[ ${AC_NO_BUILD_unordered_dense} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::unordered_dense"

sudo mkdir -p ./unordered_dense/

sudo wget "https://github.com/martinus/unordered_dense/archive/refs/tags/v${VERSION}.tar.gz" -O ./unordered_dense.tar.gz
sudo tar -I pigz -xf ./unordered_dense.tar.gz -C ./unordered_dense/ --strip-components 1

cd ./unordered_dense/

sudo mkdir -p ./build/ && cd ./build/

sudo cmake "${CMAKE_ENVIRONMENT[@]}" \
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]}" \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/ \
    ../

sudo cmake --build ./ --target install

echo "::endgroup::"
)


# z3
(
VERSION="4.13.3"

set +u
if [[ ${AC_NO_BUILD_z3} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::Z3"

sudo mkdir -p ./z3/

sudo wget -q "https://github.com/Z3Prover/z3/archive/refs/tags/z3-${VERSION}.tar.gz" -O ./z3.tar.gz
sudo tar -I pigz -xf ./z3.tar.gz -C ./z3/ --strip-components 1

cd ./z3/

sudo mkdir -p ./build/ && cd ./build/

sudo cmake "${CMAKE_ENVIRONMENT[@]}" \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/ \
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]}" \
    ../

sudo cmake --build ./ --target install

echo "::endgroup::"
)


if [ -v ATCODER ]; then
    echo "::group::finalize"

    find /opt/ac_install/ \
        -name cmake -or -name pkgconfig -or -name bin -or -name share \
        -type d -print0 |
        xargs -0 sudo rm -rf

    sudo apt-get remove -y --auto-remove git cmake ninja-build pigz pbzip2

    echo "::endgroup::"
fi

