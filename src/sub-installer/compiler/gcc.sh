#!/bin/bash
set -eu
if "${AC_NO_BUILD_COMPILER:-false}"; then exit 0; fi

echo "::group::GCC"

sudo apt-get install -y "g++-14=${VERSION}"

echo "::endgroup::"
