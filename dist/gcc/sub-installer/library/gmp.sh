#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="2:6.3.0+dfsg-2ubuntu6.1"

set -eu
if "${AC_NO_BUILD_gmp:-false}"; then exit 0; fi

echo "::group::gmp"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
