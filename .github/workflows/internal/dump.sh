#!/bin/bash
set -eu

echo
echo '## GCC'

if [ -f ./dist/gcc/install.sh ]; then
    echo '### Install Script'
    echo '```bash'
    cat ./dist/gcc/install.sh
    echo '```'
fi

if [ -f ./dist/gcc/compile.sh ]; then
    echo '### Compile Script'
    echo '```bash'
    cat ./dist/gcc/compile.sh
    echo '```'
fi

if [ -f ./dist/gcc/config.toml ]; then
    echo '### Configuration'
    echo '```toml'
    cat ./dist/gcc/config.toml
    echo '```'
fi

echo
echo '## Clang'

if [ -f ./dist/clang/install.sh ]; then
    echo '### Install Script'
    echo '```bash'
    cat ./dist/clang/install.sh
    echo '```'
fi

if [ -f ./dist/clang/compile.sh ]; then
    echo '### Compile Script'
    echo '```bash'
    cat ./dist/clang/compile.sh
    echo '```'
fi

if [ -f ./dist/clang/config.toml ]; then
    echo '### Configuration'
    echo '```toml'
    cat ./dist/clang/config.toml
    echo '```'
fi
