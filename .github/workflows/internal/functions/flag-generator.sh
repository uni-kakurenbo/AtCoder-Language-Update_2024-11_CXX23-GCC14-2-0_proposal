# shellcheck disable=all

set -eu

DIST_DIR="$1"

CONFIG_PATHS=(
    "${DIST_DIR}/config/"
    "${DIST_DIR}/config/internal/"
    "${DIST_DIR}/config/library/"
    "./pkgconfig/"

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
