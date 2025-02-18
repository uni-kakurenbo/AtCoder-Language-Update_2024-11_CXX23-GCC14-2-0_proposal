#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="2.6.0"

set -eu
if [[ "${AC_NO_BUILD_libtorch:-false}" == true || \
    "${AC_VARIANT:-false}" == "clang" ]]; then
    exit 0
fi

cd /tmp/ac_install/

echo "::group::LibTorch"

sudo wget "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-${VERSION}%2Bcpu.zip" -O ./libtorch.zip
sudo unzip -o ./libtorch.zip -d ./

sudo mkdir -p /opt/ac_install/include/
sudo mkdir -p /opt/ac_install/lib/

# remove protobuf, which or-tools has as its dependencies.
sudo rm -f ./libtorch/lib/libprotobuf.a
sudo rm -f ./libtorch/lib/libprotobuf-lite.a
sudo rm -f ./libtorch/lib/libprotoc.a

sudo cp -Trf ./libtorch/include/ /opt/ac_install/include/
sudo cp -Trf ./libtorch/lib/ /opt/ac_install/lib/

echo "::endgroup::"
