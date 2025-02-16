#!/bin/bash
set -eu

DIST_DIR="./dist/$1"

WORKING_DIRECTORY="$(dirname "$0")/../"

# shellcheck source=/dev/null
source "${WORKING_DIRECTORY}/functions/flag-generator.sh" "${DIST_DIR}"

"${WORKING_DIRECTORY}/replacers/pkg-config.sh" "${DIST_DIR}"

gen-flags ac_user | tr ' ' '\n' >"${DIST_DIR}/user.flags.txt"
cat "${DIST_DIR}/user.flags.txt"

"${WORKING_DIRECTORY}/replacers/compiler.sh" "${DIST_DIR}"

chmod +x -R ./dist/
