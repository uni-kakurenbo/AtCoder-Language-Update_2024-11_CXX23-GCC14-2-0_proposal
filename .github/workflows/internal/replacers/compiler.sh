#!/bin/bash
set -eu

SHEBANG='#!/bin/bash'
DIST_DIR="$1"

{
    format() { sed -e 's/^/    "/' -e 's/$/"/'; }

    echo "${SHEBANG}"
    cat ./assets/warning.txt

    echo
    echo "BUILD_FLAGS=("
    format <"${DIST_DIR}/user.flags.txt"
    echo ")"

    TARGET="$(cat ./src/compile.sh)"
    echo "${TARGET//"${SHEBANG}"/}"
} >"${DIST_DIR}/compile.sh"
