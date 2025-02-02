#!/bin/bash
set -eu

INSTALLER="$(sed -e '/^\#/d' ./dist/install.sh | tr -s ' \n')"
BUILDER="$(sed -e '/^\#/d' ./dist/compile.sh | tr -s ' \n')"

cat ./assets/warning.txt >./dist/config.toml
echo >>./dist/config.toml

dasel -r toml -w json <./src/config.toml |
    jq --arg installer "${INSTALLER}" '.install=$installer' |
    jq --arg builder "${BUILDER}" '.compile=$builder' |
    dasel -r json -w toml |
    tr -s ' \n' |
    sed -e 's/^\s*//g' >>./dist/config.toml

function format-version() {
    local target
    target="$(cat ./dist/config.toml)"

    if [[ $1 =~ ([0-9]+\.){1}[0-9]+(\.[0-9]+)? ]]; then
        echo "${target/$1/version = \'${BASH_REMATCH[0]}\'}" >./dist/config.toml
    fi
}

export -f format-version

grep -Po "version\s*=\s*['\"].*([0-9]+\.){1}[0-9]+(\.[0-9]+)?.*['\"]" ./dist/config.toml |
    xargs -d'\n' -I {} bash -c 'format-version "{}"'
