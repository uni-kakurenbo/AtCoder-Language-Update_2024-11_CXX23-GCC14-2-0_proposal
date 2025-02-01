#!/bin/bash
set -eu

WORKING_DIRECTORY="$(dirname "$0")"

echo "::group::ccache"
ccache --version || sudo apt-get install -y ccache
echo "::endgroup::"

echo "::group::dasel"
dasel --version || sudo apt-get install -y dasel
echo "::endgroup::"

echo "::group::jq"
jq --version || sudo apt-get install -y jq
echo "::endgroup::"

echo "::group::pkg-config"
"${WORKING_DIRECTORY}/tools/pkg-config.sh"
echo "::endgroup::"

echo "::group::taplo"
"${WORKING_DIRECTORY}/tools/taplo.sh"
echo "::endgroup::"

mkdir -p /opt/ac_tools/bin/
mkdir -p /opt/ac_tools/lib/

which pkg-config ccache dasel jq taplo | xargs -I {} cp {} /opt/ac_tools/bin/
find /usr/lib/ -iname 'libhiredis.so*' -print0 | xargs -0 -I {} cp {} /opt/ac_tools/lib/

rm -rf ./dist/ && mkdir -p ./dist/
