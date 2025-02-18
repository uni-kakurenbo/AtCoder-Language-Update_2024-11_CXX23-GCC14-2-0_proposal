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
export HEADER

{
    format() { sed -e 's/^/"/' -e 's/$/"/'; }

    INSTALLER="$(cat ./src/install.sh)"

    echo
    cat ./assets/parallel.sh

    echo
    echo "AC_VARIANT=${VARIANT}"

    echo
    echo "BUILD_FLAGS=("
    format <"${DIST_DIR}/internal.flags.txt"
    echo ")"

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
    content="${content//"${HEADER}"/}"

    local target
    target=$(cat ./install.sh)

    echo -e "${target//"$1"/"\n# ${name}\n${content}\n"}" >./install.sh
}

export -f replace

cd "${DIST_DIR}"

find ./sub-installer/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {}"

echo >>./install.sh

shfmt -i 4 -w ./install.sh
