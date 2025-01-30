#!/bin/bash
set +u
if [[ ${AC_NO_BUILD_gmp} ]]; then exit 0; fi
set -eu

echo "::group::gmp"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
