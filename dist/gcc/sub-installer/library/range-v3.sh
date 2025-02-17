#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="0.12.0"

set -eu
if "${AC_NO_BUILD_range_v3:-false}"; then exit 0; fi

cd /tmp/ac_install/

echo "::group::range-v3"

sudo mkdir -p ./range-v3/

sudo wget -q "https://github.com/ericniebler/range-v3/archive/refs/tags/${VERSION}.tar.gz" -O ./range-v3.tar.gz
sudo tar -I pigz -xf ./range-v3.tar.gz -C ./range-v3/ --strip-components 1

sudo mkdir -p /opt/ac_install/include/

sudo cp -Trf ./range-v3/include/ /opt/ac_install/include/

echo "::endgroup::"
