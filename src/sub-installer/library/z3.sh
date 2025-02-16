#!/bin/bash
set -eu
if "${AC_NO_BUILD_z3:-false}"; then exit 0; fi

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
