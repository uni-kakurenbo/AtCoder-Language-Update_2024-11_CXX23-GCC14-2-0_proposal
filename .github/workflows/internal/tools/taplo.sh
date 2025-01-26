#!/bin/bash
set -eu

taplo --version && exit 0

curl -fsSL https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-linux-x86_64.gz |
    gzip -d - | sudo install -m 755 /dev/stdin /usr/bin/taplo
