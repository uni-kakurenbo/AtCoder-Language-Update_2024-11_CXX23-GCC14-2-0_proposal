#!/bin/bash
set +u
if [[ ${AC_NO_BUILD_LibTorch} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::LibTorch"

sudo wget -q "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-${VERSION}%2Bcpu.zip" -O ./libtorch.zip
sudo unzip -oq ./libtorch.zip -d ./

sudo mkdir -p /opt/ac_install/libtorch/include/
sudo mkdir -p /opt/ac_install/libtorch/lib/

# remove protobuf, which or-tools has as its dependencies.
sudo rm -f ./libtorch/lib/libprotobuf.a
sudo rm -f ./libtorch/lib/libprotobuf-lite.a
sudo rm -f ./libtorch/lib/libprotoc.a

sudo cp -Trf ./libtorch/include/ /opt/ac_install/libtorch/include/
sudo cp -Trf ./libtorch/lib/ /opt/ac_install/libtorch/lib/

echo "::endgroup::"
