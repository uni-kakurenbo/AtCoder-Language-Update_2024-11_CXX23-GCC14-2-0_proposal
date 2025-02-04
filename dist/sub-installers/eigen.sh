#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="3.4.0-4"

set +u
if [[ ${AC_NO_BUILD_eigen} && ${AC_NO_BUILD_light_gbm} && ${AC_NO_BUILD_or_tools} ]]; then exit 0; fi
set -eu

echo "::group::Eigen3"

sudo apt-get install -y "libeigen3-dev=${VERSION}"

sudo mkdir -p /opt/ac_install/include/
sudo mkdir -p /opt/ac_install/cmake/

sudo cp -Trf /usr/include/eigen3/ /opt/ac_install/include/

# copy and patch cmake files to build OR-Tools.
sudo cp -f \
    /usr/share/eigen3/cmake/Eigen3Targets.cmake \
    /usr/share/eigen3/cmake/Eigen3Config.cmake \
    /opt/ac_install/cmake/

sudo sed -i \
    -e 's/include\/eigen3/opt\/ac_install\/include\//g' \
    /opt/ac_install/cmake/Eigen3Targets.cmake

sudo apt-get remove -y libeigen3-dev

echo "::endgroup::"
