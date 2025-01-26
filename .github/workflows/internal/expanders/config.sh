#!/bin/bash
set -eu

WORKING_DIRECTORY="$(dirname "$0")/../"

"${WORKING_DIRECTORY}/replacers/config.sh"

chmod +x -R ./dist/
