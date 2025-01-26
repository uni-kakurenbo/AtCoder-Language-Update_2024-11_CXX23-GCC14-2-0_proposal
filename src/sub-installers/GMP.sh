#!/bin/bash
set +u
if [[ ${AC_NO_BUILD_GMP} ]]; then exit 0; fi
set -eu

echo "::group::GMP"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
