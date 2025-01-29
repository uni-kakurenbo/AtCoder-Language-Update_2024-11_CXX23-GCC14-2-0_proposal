#!/bin/bash
set -eu

WORKING_DIRECTORY="$(dirname "$0")"

echo "::group::dasel"
dasel || sudo apt-get install -y dasel
echo "::endgroup::"

echo "::group::jq"
jq || sudo apt-get install -y jq
echo "::endgroup::"

"${WORKING_DIRECTORY}/tools/pkg-config.sh"
"${WORKING_DIRECTORY}/tools/taplo.sh"

rm -rf ./dist/ && mkdir -p ./dist/
