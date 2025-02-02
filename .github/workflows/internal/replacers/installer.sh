#!/bin/bash
set -eu

SHEBANG='#!/bin/bash'

{
    echo "${SHEBANG}"
    cat ./assets/warning.txt
} >./dist/install.sh

HEADER="$(cat ./dist/install.sh)"

VERSION="$(dasel -r toml -w json <./src/config.toml | jq '.version')"

{
    format() { sed 's/^/    "/' | sed 's/$/"/'; }

    INSTALLER="$(sed -e '/^\#/d' ./src/install.sh)"

    echo
    cat ./assets/parallel.sh

    echo
    echo "BUILD_FLAGS=("
    format <./dist/internal.flags.txt
    echo ")"

    echo -e "\nVERSION=${VERSION}"

    echo
    echo -e "${INSTALLER//${SHEBANG}/}"
} >>./dist/install.sh

mkdir -p ./dist/

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

cd ./dist/

find ./sub-installers/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {} \"${HEADER}\""

echo >>./install.sh
