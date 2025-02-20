#!/bin/bash
set -eu

export OUTPUT="./test/merged.cpp"

echo "" >"${OUTPUT}"

function replace() {
    local target="$1"

    local tag="${target}"
    tag="${tag//.test.cpp/}"
    tag="${tag//.\//}"
    tag="${tag//\//_}"
    tag="${tag//-/_}"

    local content
    content="$(cat "${target}")"
    content="${content//int main()/"void ${tag}(int, char* [])"}"
    content="${content//int main/"void ${tag}"}"

    {
        echo
        echo "${content}"
    } >>"${OUTPUT}"

    echo "${tag}"
}

export -f replace

MAIN="$(
    # shellcheck disable=SC2016
    find ./test/ -iname '*.test.cpp' -print0 |
        xargs -0 -I {} bash -c 'echo "$(replace {})(argc, argv);"'
)"

{
    echo "int main(int argc, char* argv[]) {"
    echo "${MAIN}"
    echo "}"
} >>"${OUTPUT}"
