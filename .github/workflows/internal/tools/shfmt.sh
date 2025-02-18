#!/bin/bash
set -eu

if shfmt --version; then exit 0; fi

sudo mkdir -p /tmp/ac_tools/ && cd /tmp/ac_tools/

sudo curl -L https://github.com/mvdan/sh/releases/download/v3.1.1/shfmt_v3.1.1_linux_amd64 -o ./shfmt
sudo chmod +x ./shfmt

sudo mv ./shfmt /usr/local/bin/
