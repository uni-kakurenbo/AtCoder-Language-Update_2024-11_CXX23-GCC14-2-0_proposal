#!/bin/bash
set -eu

export SHEBANG="#!/bin/bash"

export DIST_DIR="$1"

export VARIANT
VARIANT="$(basename "${DIST_DIR}")"

mkdir -p "${DIST_DIR}/sub-installer/library/"

function replace() {
    local name
    name="$(basename "$1")"
    name="${name//.sh/}"

    local type="$2"

    local dist="${DIST_DIR}/sub-installer/${type}/${name}.sh"
    mkdir -p "$(dirname "${dist}")"

    local version

    if [[ "${type}" = "library" ]]; then
        version="$(
            dasel -r toml -w json <./src/config.toml |
                jq --arg name "${name}" --arg variant "${VARIANT}" \
                    '.library[$name].version // .variant[$variant].library[$name].version'
        )"
    else
        version="$(
            dasel -r toml -w json <./src/config.toml |
                jq --arg name "${name}" \
                    '.version // .variant[$name].version'
        )"
    fi

    target="$(cat "$1")"

    echo "${SHEBANG}" >"${dist}"
    cat ./assets/warning.txt >>"${dist}"
    echo -e "${target/"${SHEBANG}"/"VERSION=${version}\n"}" >>"${dist}"
}

export -f replace

find ./src/sub-installer/library/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {} library"

find ./src/sub-installer/compiler/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {} compiler"
