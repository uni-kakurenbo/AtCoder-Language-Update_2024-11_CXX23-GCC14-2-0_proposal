#!/bin/bash
set -eu
if "${AC_NO_BUILD_boost:-false}"; then exit 0; fi

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

if [[ -v CCACHE_ENABLED ]]; then
    sudo sed -i \
        -e 's/test_compiler g++$TOOLSET_SUFFIX/test_compiler "ccache g++$TOOLSET_SUFFIX"/g' \
        -e 's/test_compiler clang++$TOOLSET_SUFFIX/test_compiler "ccache clang++$TOOLSET_SUFFIX"/g' \
        ./tools/build/src/engine/build.sh
fi

sudo ./bootstrap.sh \
    --with-toolset="${AC_VARIANT}" \
    --without-libraries=mpi,graph_parallel \
    --prefix=/opt/ac_install/

sudo ./b2 \
    toolset="${AC_VARIANT}" \
    link=static \
    threading=single \
    variant=release \
    cflags="-w" \
    cxxflags="${BUILD_FLAGS[*]}" \
    --user-config="./user-config.jam" \
    -j"${PARALLEL}" -d0 \
    install

echo "::endgroup::"
