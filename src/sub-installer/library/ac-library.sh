#!/bin/bash
set -eu
if "${AC_NO_BUILD_ac_library:-false}"; then exit 0; fi

cd /tmp/ac_install/

echo "::group::AC Library"

sudo wget -q "https://github.com/atcoder/ac-library/releases/download/v${VERSION}/ac-library.zip" -O ./ac-library.zip
sudo unzip -oq ./ac-library.zip -d /opt/ac_install/include/

echo "::endgroup::"
