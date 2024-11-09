#!/bin/bash
set -eu

SHEBANG='#!/bin/bash'

sudo apt-get install -y dasel
sudo apt-get install -y jq

mkdir -p ./dist/sub-installers/

function replace() {
    local name
    name="$(basename "$1")"
    name="${name//.sh/}"

    local dist="./dist/sub-installers/${name}.sh"

    local version
    version="$(dasel -r toml -w json <./src/install.toml | jq --arg name "${name}" '.library[$name].version')"

    target="$(cat "$1")"

    echo "$2" >"${dist}"
    cat ./assets/warning.txt >>"${dist}"
    echo -e "${target/"$2"/"VERSION=${version}\n"}" >>"${dist}"
}

export -f replace

time find ./src/sub-installers/ -type f -name '*.sh' -print0 |
    xargs -0 -I {} bash -c "replace {} \"${SHEBANG}\""
