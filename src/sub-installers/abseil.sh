#!/bin/bash
set -eu

cd /tmp/ac_install/

echo "::group::abseil"

sudo mkdir -p ./abseil/

sudo wget -q "https://github.com/abseil/abseil-cpp/releases/download/${VERSION}/abseil-cpp-${VERSION}.tar.gz" -O ./abseil.tar.gz
sudo tar -I pigz -xf ./abseil.tar.gz -C ./abseil/ --strip-components 1

cd ./abseil/

sudo mkdir -p ./build/ && cd ./build/

BUILD_ARGS=(
    -DABSL_ENABLE_INSTALL:BOOL=ON
    -DABSL_PROPAGATE_CXX_STD:BOOL=ON
    -DABSL_USE_SYSTEM_INCLUDES:BOOL=ON
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/abseil/
    -DCMAKE_CXX_FLAGS:STRING="${BUILD_FLAGS[*]} -fPIC"
)

if [[ -v RUN_TEST ]] && [[ "${RUN_TEST}" = "true" ]]; then
    sudo cmake -DABSL_BUILD_TESTING=ON -DABSL_USE_GOOGLETEST_HEAD=ON "${BUILD_ARGS[@]}" ../

    sudo make "-j${PARALLEL}"
    sudo ctest --parallel "${PARALLEL}"
else
    sudo cmake "${BUILD_ARGS[@]}" ../
fi

sudo cmake --build ./ --target install

echo "::endgroup::"
