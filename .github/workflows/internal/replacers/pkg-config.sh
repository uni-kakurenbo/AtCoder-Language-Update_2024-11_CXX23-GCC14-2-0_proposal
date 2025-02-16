#!/bin/bash
set -eu

export DIST_DIR="$1"

mkdir -p "${DIST_DIR}/config/"

function replace() {
    local target="$1"
    local dist="${DIST_DIR}/${target}"

    mkdir -p "$(dirname "${dist}")"

    dasel -r yaml -w json <"${target}" >"${DIST_DIR}/.tmp.json"

    jq -r --arg variant "$(basename "${DIST_DIR}")" --slurpfile this "${DIST_DIR}/.tmp.json" \
        '.Cflags += "" | .Libs += "" | with_entries(.value += $this[0].variant[$variant][.key]) | del(.variant)' "${DIST_DIR}/.tmp.json" |
        dasel -r json -w yaml |
        sed -E -e 's/\\//g' -e 's/ +/ /g' -e 's/ \|//g' |
        dasel -r yaml --pretty=false |
        sed -E -e 's/\snull\s/ ""/g' -e 's/\snull$/ ""/g' >"${dist//.yml/.pc}"
}

export -f replace

find ./config/ -type f -print0 | xargs -0 -I {} bash -c 'replace {}'
