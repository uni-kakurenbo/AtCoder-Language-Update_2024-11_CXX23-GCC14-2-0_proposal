#!/bin/bash
set -eu

cd /tmp/ac_install/

echo "::group::GCC"

sudo apt-get install -y "g++-14=${VERSION}"

echo "::endgroup::"
