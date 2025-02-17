#!/bin/bash
set -eu

OUTPUT=./test/merged.test.cpp

mkdir -p ./test/
echo "" >"${OUTPUT}"

function replace() {
    local target="$1"

    local category
    category="$(basename "$(dirname "${target}")")"

    local name
    name="$(basename "${target}")"
    name="${name//.test.cpp/}"

    local content
    content="$(cat "${target}")"

    local tag="test_${category}_${name}"
    tag="${tag//-/_}"

    {
        echo
        echo "${content//int main()/"void ${tag}()"}"
    } | sed -E -e 's/^ +//g' | tr '\n' '\r' | sed -E -e 's/ +/ /g' -e 's/\r+/\r/g' | tr '\r' '\n' >>"${OUTPUT}"

    echo "${tag}"
}

export -f replace

MAIN="$(
    find ./test/ -iname '*.test.cpp' -print0 |
        xargs -0 -I {} bash -c "replace {}" |
        xargs -I {} echo '{}();'
)"

{
    echo "int main() {"
    echo "${MAIN}"
    echo "}"
} >>"${OUTPUT}"
