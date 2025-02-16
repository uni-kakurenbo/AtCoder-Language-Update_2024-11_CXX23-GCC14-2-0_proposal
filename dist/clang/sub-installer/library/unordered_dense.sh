#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
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
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/ \
    ../

sudo cmake --build ./ --target install

echo "::endgroup::"
