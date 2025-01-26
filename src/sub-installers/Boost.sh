#!/bin/bash
set -eu

cd /tmp/ac_install/

echo "::group::Boost"

sudo mkdir -p ./boost/

sudo wget -q "https://archives.boost.io/release/${VERSION}/source/boost_${VERSION//./_}.tar.bz2" -O ./boost.tar.bz2
sudo tar -I pbzip2 -xf ./boost.tar.bz2 -C ./boost/ --strip-components 1

cd ./boost/

sudo ./bootstrap.sh \
    --with-toolset=gcc \
    --without-libraries=mpi,graph_parallel \
    --prefix=/opt/ac_install/boost/

BUILD_ARGS=(
    -d0
    "-j$(nproc)"
    "toolset=gcc"
    "link=static"
    "threading=single"
    "variant=release"
    "cflags=-w"
    "cxxflags=${BUILD_FLAGS[*]}"
)

sudo ./b2 "${BUILD_ARGS[@]}" -j "${PARALLEL}" install

echo "::endgroup::"
