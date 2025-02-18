#!/bin/bash
set -eu

export DIST_DIR="$1"

VARIANT="$(basename "${DIST_DIR}")"
export VARIANT

INSTALLER="$(shfmt -mn "${DIST_DIR}/install.sh")"
COMPILER="$(shfmt -mn "${DIST_DIR}/compile.sh")"

cat ./assets/warning.txt >"${DIST_DIR}/config.toml"
echo >>"${DIST_DIR}/config.toml"

dasel -r toml -w json <./src/config.toml |
    jq --arg installer "${INSTALLER}" '.install=$installer' |
    jq --arg compiler "${COMPILER}" '.compile=$compiler' |
    jq --arg variant "gcc" '. * .variant[$variant] | del(.variant)' |
    dasel -r json -w toml |
    tr -s ' \n' |
    sed -e 's/^\s*//g' >>"${DIST_DIR}/config.toml"

function format-version() {
    local target
    target="$(cat "${DIST_DIR}/config.toml")"

    if [[ $1 =~ ([0-9]+\.){1}[0-9]+(\.[0-9]+)? ]]; then
        echo "${target/$1/version = \'${BASH_REMATCH[0]}\'}" >"${DIST_DIR}/config.toml"
    fi
}

export -f format-version

grep -Po "version\s*=\s*['\"].*([0-9]+\.){1}[0-9]+(\.[0-9]+)?.*['\"]" "${DIST_DIR}/config.toml" |
    xargs -d'\n' -I {} bash -c 'format-version "{}"'
