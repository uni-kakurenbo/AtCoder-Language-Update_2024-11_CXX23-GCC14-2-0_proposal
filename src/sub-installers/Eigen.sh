#!/bin/bash
set -eu

echo "::group::Eigen3"

sudo apt-get install -y "libeigen3-dev=${VERSION}"

sudo mkdir -p /opt/ac_install/eigen3/include/
sudo mkdir -p /opt/ac_install/eigen3/cmake/

sudo cp -Trf /usr/include/eigen3/ /opt/ac_install/eigen3/include/

# copy and modify cmake files to build or-tools.
sudo cp -f \
    /usr/share/eigen3/cmake/Eigen3Targets.cmake \
    /usr/share/eigen3/cmake/Eigen3Config.cmake \
    /opt/ac_install/eigen3/cmake/

sudo sed -i \
    -e 's/include\/eigen3/ac_install\/eigen3\/include/g' \
    /opt/ac_install/eigen3/cmake/Eigen3Targets.cmake

sudo apt-get remove -y libeigen3-dev

echo "::endgroup::"
