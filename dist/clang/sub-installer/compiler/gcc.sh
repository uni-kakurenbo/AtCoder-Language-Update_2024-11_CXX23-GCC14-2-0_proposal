#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="14.2.0-4ubuntu2~24.04"

set -eu
if "${AC_NO_BUILD_COMPILER:-false}"; then exit 0; fi

echo "::group::GCC"

sudo apt-get install -y "g++-14=${VERSION}"

echo "::endgroup::"
