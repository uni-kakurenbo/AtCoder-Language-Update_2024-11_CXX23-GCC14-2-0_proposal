#!/bin/bash
set -eu

cd /tmp/ac_install/

echo "::group::Clang"

sudo apt-get install -y lsb-release software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh

chmod +x llvm.sh

sudo ./llvm.sh 19
sudo apt-get install -y libc++-19-dev
sudo apt-get purge -y --auto-remove lsb-release software-properties-common gnupg

echo "::endgroup::"
