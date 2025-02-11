# shellcheck disable=all

set -eu

export PATH="${PATH}:/opt/ac_tools/bin/"

DIST_DIR="$1"

echo "${DIST_DIR}"

CONFIG_PATHS=(
    "${DIST_DIR}/config/"
    "${DIST_DIR}/config/internal/"
    "${DIST_DIR}/config/library/"
    "${DIST_DIR}/config/libs/"

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
