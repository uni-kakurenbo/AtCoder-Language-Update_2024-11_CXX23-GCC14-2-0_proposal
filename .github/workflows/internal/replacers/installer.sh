#!/bin/bash
set -eu

SHEBANG='#!/bin/bash'
DIST_DIR="$1"
VARIANT="$(basename "${DIST_DIR}")"

{
    echo "${SHEBANG}"
    cat ./assets/warning.txt
} >"${DIST_DIR}/install.sh"

HEADER="$(cat "${DIST_DIR}/install.sh")"

VERSION="$(
    dasel -r toml -w json <./src/config.toml |
        jq --arg variant "${VARIANT}" '.variant[$variant].version'
)"

{
    format() { sed -e 's/^/    "/' -e 's/$/"/'; }

    INSTALLER="$(sed -e '/^\#/d' ./src/install.sh)"

    echo
    cat ./assets/parallel.sh

    echo
    echo "AC_VARIANT=${VARIANT}"

    echo
    echo "BUILD_FLAGS=("
    format <"${DIST_DIR}/internal.flags.txt"
    echo ")"

    echo
    echo "VERSION=${VERSION}"

    echo
    echo -e "${INSTALLER//${SHEBANG}/}"
} >>"${DIST_DIR}/install.sh"

mkdir -p "${DIST_DIR}"

function replace() {
    local name
    name="$(basename "$1")"
    name="${name//.sh/}"

    local content
    content="($(cat "$1")\n)"
    content="${content//"$2"/}"

    local target
    target=$(cat ./install.sh)

    echo -e "${target//"$1"/"\n# ${name}\n${content}\n"}" >./install.sh
}

export -f replace

cd "${DIST_DIR}"

find ./sub-installers/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {} \"${HEADER}\""

echo >>./install.sh
