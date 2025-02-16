#!/bin/bash
set -eu
if "${AC_NO_BUILD_gmp:-false}"; then exit 0; fi

echo "::group::gmp"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
