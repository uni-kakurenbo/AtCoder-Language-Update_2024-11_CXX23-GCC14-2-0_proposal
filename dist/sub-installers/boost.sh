#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
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

echo "using gcc : : ccache g++-14 ;" | sudo tee -a ./user-config.jam

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
