#!/bin/bash
set -eu

DIST_DIR="./dist/$1"

WORKING_DIRECTORY="$(dirname "$0")/../"

"${WORKING_DIRECTORY}/replacers/config.sh" "${DIST_DIR}"
