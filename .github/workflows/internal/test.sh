#!/bin/bash
set -eu

export DIST_DIR="./dist/$1"

chmod +x -R "${DIST_DIR}"

cd ./test/

function run-test() {
    set -eu

    local name
    name="$(dirname "$1")/$(basename "$1")"

    local directory="./tmp/${name}"

    mkdir -p "${directory}"
    cp -f "../${DIST_DIR}/compile.sh" "${directory}/compile.sh"
    cp -f "$1" "${directory}/Main.cpp"

    cd "${directory}/"

    local exit_status
    exit_status=0

    {
        set +e
        local header="================================ ${name} ================================"

        echo "::group::${name}"

        echo "${header}"

        ./compile.sh
        exit_status=$((exit_status + $?))

        echo "${header//[^\$]/-}"

        ./a.out
        exit_status=$((exit_status + $?))

        echo "${header//[^=]/=}"
        echo
        echo

        if [ ${exit_status} -gt 0 ]; then
            echo "error" >./../../fail.txt
        fi

        echo "::endgroup::"

        set -e
    } >&./log.txt
    cat ./log.txt
}

export -f run-test

if [[ "$#" -lt 2 ]]; then
    find ./ -type f -name '*.test.cpp' -print0 |
        xargs -0 -P0 -I {} bash -c 'run-test {}'
else
    shift

    echo "$@" | xargs -d' ' "-P$(nproc)" -I {} bash -c 'run-test {}'
fi

FAIL=false

if [ -f ./tmp/fail.txt ]; then
    FAIL=true
fi

sudo rm -rf ./tmp/

if [[ ${FAIL} = true ]]; then
    exit 1
fi
