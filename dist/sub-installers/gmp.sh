#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="2:6.3.0+dfsg-2ubuntu6"

set +u
if [[ ${AC_NO_BUILD_gmp} ]]; then exit 0; fi
set -eu

echo "::group::gmp"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
