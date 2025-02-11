#!/bin/bash
set -eu

SHEBANG='#!/bin/bash'
DIST_DIR="$1"

mkdir -p "${DIST_DIR}/sub-installers/"

echo "${DIST_DIR}"

function replace() {
    local name
    name="$(basename "$1")"
    name="${name//.sh/}"

    local dist="${DIST_DIR}/sub-installers/${name}.sh"

    local version
    version="$(dasel -r toml -w json <./src/config.toml | jq --arg name "${name}" '.library[$name].version')"

    target="$(cat "$1")"

    echo "$2" >"${dist}"
    cat ./assets/warning.txt >>"${dist}"
    echo -e "${target/"$2"/"VERSION=${version}\n"}" >>"${dist}"
}

export -f replace

find ./src/sub-installers/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {} \"${SHEBANG}\""
