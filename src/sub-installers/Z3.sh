#!/bin/bash
set -eu

cd /tmp/ac_install/

echo "::group::Z3"

sudo mkdir -p ./z3/

sudo wget -q "https://github.com/Z3Prover/z3/archive/refs/tags/z3-${VERSION}.tar.gz" -O ./z3.tar.gz
sudo tar -I pigz -xf ./z3.tar.gz -C ./z3/ --strip-components 1

cd ./z3/

sudo mkdir -p ./build/ && cd ./build/

sudo cmake -G "${GENERATOR}" \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/z3/ \
    -DCMAKE_C_FLAGS:STRING="-w" \
    -DCMAKE_CXX_COMPILER:STRING="g++-14" \
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]}" \
    -DCMAKE_INSTALL_MESSAGE:STRING=NEVER -DCMAKE_MESSAGE_LOG_LEVEL:STRING=WARNING \
    ../

sudo cmake --build ./ --target install

echo "::endgroup::"
