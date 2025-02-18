#!/bin/bash
set -eu

WORKING_DIRECTORY="$(dirname "$0")/../"
DIST_DIR="./dist/$1"

# shellcheck source=/dev/null
source "${WORKING_DIRECTORY}/functions/flag-generator.sh" "${DIST_DIR}"

"${WORKING_DIRECTORY}/replacers/pkg-config.sh" "${DIST_DIR}"

gen-flags ac_internal | sed -e 's/ +/ /' | tr ' ' '\n' >"${DIST_DIR}/internal.flags.txt"
cat "${DIST_DIR}/internal.flags.txt"

"${WORKING_DIRECTORY}/replacers/sub-installer.sh" "${DIST_DIR}"
"${WORKING_DIRECTORY}/replacers/installer.sh" "${DIST_DIR}"

chmod +x -R ./dist/
