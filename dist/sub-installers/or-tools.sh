#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
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
