#!/bin/bash
set -eu

SHEBANG='#!/bin/bash'

{
    format() { sed 's/^/    "/' | sed 's/$/"/'; }

    echo "${SHEBANG}"
    cat ./assets/warning.txt

    echo
    echo "BUILD_FLAGS=("
    format <./dist/user.flags.txt
    echo ")"

    TARGET="$(cat ./src/compile.sh)"
    echo "${TARGET//"${SHEBANG}"/}"
} >./dist/compile.sh
