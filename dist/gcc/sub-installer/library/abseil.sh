#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="20240722.0"

set +u
if [[ ${AC_NO_BUILD_abseil} && ${AC_NO_BUILD_or_tools} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::abseil"

sudo mkdir -p ./abseil/

sudo wget -q "https://github.com/abseil/abseil-cpp/releases/download/${VERSION}/abseil-cpp-${VERSION}.tar.gz" -O ./abseil.tar.gz
sudo tar -I pigz -xf ./abseil.tar.gz -C ./abseil/ --strip-components 1

cd ./abseil/

sudo mkdir -p ./build/ && cd ./build/

CMAKE_ARGUMENTS=(
    "${CMAKE_ENVIRONMENT[@]}"
    -DABSL_ENABLE_INSTALL:BOOL=ON
    -DABSL_PROPAGATE_CXX_STD:BOOL=ON
    -DABSL_USE_SYSTEM_INCLUDES:BOOL=ON
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/ac_install/
    -DCMAKE_CXX_FLAGS:STRING="-fPIC ${BUILD_FLAGS[*]}"
)

if [[ -v AC_RUN_TEST ]] && [[ "${AC_RUN_TEST}" = "true" ]]; then
    sudo cmake -DABSL_BUILD_TESTING=ON -DABSL_USE_GOOGLETEST_HEAD=ON "${CMAKE_ARGUMENTS[@]}" ../

    sudo make "-j${PARALLEL}"
    sudo ctest --parallel "${PARALLEL}"
else
    sudo cmake "${CMAKE_ARGUMENTS[@]}" ../
fi

sudo cmake --build ./ --target install

echo "::endgroup::"
