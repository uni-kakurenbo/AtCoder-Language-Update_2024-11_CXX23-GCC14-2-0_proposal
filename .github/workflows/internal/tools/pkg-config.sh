#!/bin/bash
set -eu

export PATH="${PATH}:/opt/ac_tools/bin/"

if pkg-config --version; then exit 0; fi

VERSION="0.29.2"

echo "::group::pkg-config"

sudo mkdir -p /tmp/ac_tools/ && cd /tmp/ac_tools/

sudo wget https://pkg-config.freedesktop.org/releases/pkg-config-${VERSION}.tar.gz
sudo tar -xf pkg-config-${VERSION}.tar.gz

cd ./pkg-config-${VERSION}

sudo ./configure --with-internal-glib --prefix=/opt/ac_tools/

sudo make
sudo make install "-j$(nproc)"

echo "::endgroup::"
