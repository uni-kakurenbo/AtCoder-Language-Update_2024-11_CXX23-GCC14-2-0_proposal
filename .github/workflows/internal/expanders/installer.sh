#!/bin/bash
set -eu

WORKING_DIRECTORY="$(dirname "$0")/../"

# shellcheck source=/dev/null
source "${WORKING_DIRECTORY}/functions/flag-generator.sh"

gen-flags ac_internal | tr ' ' '\n' >./dist/internal.flags.txt
cat ./dist/internal.flags.txt

"${WORKING_DIRECTORY}/replacers/sub-installers.sh"
"${WORKING_DIRECTORY}/replacers/installer.sh"

chmod +x -R ./dist/
