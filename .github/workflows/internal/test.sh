#!/bin/bash
set -eu

chmod +x -R ./dist/

cd ./test/
mkdir -p ./tmp/

function run-test() {
    set -eu

    local name
    name="$(dirname "$1")/$(basename "$1")"

    local directory="./tmp/${name}"

    mkdir -p "${directory}"
    cp -f ../dist/compile.sh "${directory}/compile.sh"
    cp -f "$1" "${directory}/Main.cpp"

    cd "${directory}/"

    local exit_status
    exit_status=0

    {
        set +e
        local header="================ ${name} ================"

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
            cat "error" >./../../fail.txt
        fi

        set -e
    } >&./log.txt
    cat ./log.txt
}

export -f run-test

find ./ -type f -name '*.test.cpp' -print0 |
    xargs -0 "-P$(nproc)" -I {} bash -c 'run-test {}'

FAIL=false

if [ -f ./tmp/fail.txt ]; then
    FAIL=true
fi

sudo rm -rf ./tmp/

if [[ ${FAIL} = true ]]; then
    exit 1
fi
