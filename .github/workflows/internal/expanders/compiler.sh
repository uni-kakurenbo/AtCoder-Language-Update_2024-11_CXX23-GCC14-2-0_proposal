#!/bin/bash
set -eu

WORKING_DIRECTORY="$(dirname "$0")/../"

# shellcheck source=/dev/null
source "${WORKING_DIRECTORY}/functions/flag-generator.sh"

gen-flags ac_user | tr ' ' '\n' >./dist/user.flags.txt
cat ./dist/user.flags.txt

"${WORKING_DIRECTORY}/replacers/compiler.sh"

chmod +x -R ./dist/
