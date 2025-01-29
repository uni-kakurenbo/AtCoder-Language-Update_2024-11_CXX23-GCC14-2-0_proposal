#!/bin/bash
set -eu

if pkg-config --version >&/dev/null; then exit 0; fi

VERSION="0.29.2"

echo "::group::pkg-config"

sudo mkdir -p /tmp/ac_tools/ && cd /tmp/ac_tools/

sudo wget https://pkg-config.freedesktop.org/releases/pkg-config-${VERSION}.tar.gz
sudo tar -xf pkg-config-${VERSION}.tar.gz

cd ./pkg-config-${VERSION}

sudo ./configure --with-internal-glib

sudo make
sudo make install "-j$(nproc)"

echo "::endgroup::"
