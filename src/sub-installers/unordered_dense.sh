#!/bin/bash
set -eu

cd /tmp/ac_install/

echo "::group::unordered_dense"

sudo mkdir -p ./unordered_dense/

sudo wget "https://github.com/martinus/unordered_dense/archive/refs/tags/v${VERSION}.tar.gz" -O ./unordered_dense.tar.gz
sudo tar -I pigz -xf ./unordered_dense.tar.gz -C ./unordered_dense/ --strip-components 1

cd ./unordered_dense/

sudo mkdir -p ./build/ && cd ./build/

sudo cmake -G "${GENERATOR}" \
    -DCMAKE_C_FLAGS:STRING="-w" \
    -DCMAKE_CXX_COMPILER:STRING="g++-14" \
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]}" \
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/unordered_dense/ \
    -DCMAKE_INSTALL_MESSAGE:STRING=NEVER -DCMAKE_MESSAGE_LOG_LEVEL:STRING=WARNING \
    ../

sudo cmake --build ./ --target install

echo "::endgroup::"
