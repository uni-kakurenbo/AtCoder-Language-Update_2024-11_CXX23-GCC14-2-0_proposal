#!/bin/bash
set -eu

taplo --version >&/dev/null && exit 0

echo "::group::taplo"

curl -fsSL https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-linux-x86_64.gz |
    gzip -d - | install -m 755 /dev/stdin /usr/local/bin/taplo

echo "::endgroup::"
