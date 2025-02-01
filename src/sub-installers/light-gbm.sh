#!/bin/bash
set +u
if [[ ${AC_NO_BUILD_light_gbm} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::LightGBM"

if [ ! -d ./light-gbm/ ]; then
    sudo mkdir -p ./light-gbm/

    sudo wget -q "https://github.com/microsoft/LightGBM/releases/download/v${VERSION}/lightgbm-${VERSION}.tar.gz" -O ./light-gbm.tar.gz
    sudo tar -I pigz -xf ./light-gbm.tar.gz -C ./light-gbm/ --strip-components 1
fi

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
