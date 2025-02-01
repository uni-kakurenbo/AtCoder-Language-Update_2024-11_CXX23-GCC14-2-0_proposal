#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="1.5.1"

set +u
if [[ ${AC_NO_BUILD_ac_library} ]]; then exit 0; fi
set -eu

cd /tmp/ac_install/

echo "::group::AC Library"

sudo wget -q "https://github.com/atcoder/ac-library/releases/download/v${VERSION}/ac-library.zip" -O ./ac-library.zip
sudo unzip -oq ./ac-library.zip -d /opt/ac_install/

echo "::endgroup::"
