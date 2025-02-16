#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="14.2.0-4ubuntu2~24.04"

set -eu

echo "::group::GCC"

sudo apt-get install -y "g++-14=${VERSION}"

echo "::endgroup::"
