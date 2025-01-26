#!/bin/bash
set -eu

echo "::group::GMP"

sudo apt-get install -y "libgmp3-dev=${VERSION}"

echo "::endgroup::"
