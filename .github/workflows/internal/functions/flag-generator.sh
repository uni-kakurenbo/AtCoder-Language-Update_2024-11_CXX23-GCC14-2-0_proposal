# shellcheck disable=all

set -eu

export PATH="${PATH}:/opt/ac_tools/bin/"

ROOT_DIR="$(dirname "$0")"
ROOT_DIR="${ROOT_DIR}/../../../../"

CONFIG_PATHS=(
    "${ROOT_DIR}/config/"
    "${ROOT_DIR}/config/internal/"
    "${ROOT_DIR}/config/library/"
    "${ROOT_DIR}/config/libs/"

    "/opt/ac_install/lib/pkgconfig/"
)

CONFIG_PATHS="${CONFIG_PATHS[@]}"
CONFIG_PATHS="${CONFIG_PATHS// /:}"

PKG_CONFIG_PATH="${CONFIG_PATHS}"
export PKG_CONFIG_PATH

function gen-flags() {
    local flags
    local libs

    flags=($(pkg-config --cflags "$@" | tr ' ' '\n' | sort -u))
    libs=($(pkg-config --libs "$@"))

    echo "${flags[@]} ${libs[@]}"
}
