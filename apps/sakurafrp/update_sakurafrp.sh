#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PKG_DIR="$SCRIPT_DIR/fnos"

APP_NAME="sakurafrp"
APP_DISPLAY_NAME="SakuraFrp"
APP_VERSION_VAR="SAKURAFRP_VERSION"
APP_VERSION="${SAKURAFRP_VERSION:-latest}"
APP_DEPS=(curl jq)
APP_FPK_PREFIX="sakurafrp"
APP_HELP_VERSION_EXAMPLE="3.1.7"

app_set_arch_vars() {
    :
}

app_show_help_examples() {
    cat << EOF
  $0 3.1.7                  # 指定版本
EOF
}

app_get_latest_version() {
    info "获取最新版本信息..."

    if [ "$APP_VERSION" = "latest" ]; then
        APP_VERSION=$(curl -sL "https://hub.docker.com/v2/repositories/natfrp/launcher/tags/?page_size=20&ordering=last_updated" | \
          jq -r '.results[].name' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | head -1)
    fi

    [ -z "$APP_VERSION" ] && error "无法获取版本信息，请手动指定: $0 3.1.7"
    info "目标版本: $APP_VERSION"
}

app_download() {
    :
}

app_build_app_tgz() {
    info "构建 app.tgz (Docker)..."
    export VERSION="$APP_VERSION"
    bash "$REPO_ROOT/scripts/apps/sakurafrp/build.sh"
    cp "$REPO_ROOT/app.tgz" "$WORK_DIR/app.tgz"
    info "app.tgz: $(du -h "$WORK_DIR/app.tgz" | cut -f1)"
}

source "$REPO_ROOT/scripts/lib/update-common.sh"
main_flow "$@"
