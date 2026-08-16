#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/meta.env"

VERSION="${VERSION:-latest}"
WORK_DIR=$(mktemp -d)
trap "rm -rf $WORK_DIR" EXIT

mkdir -p "${WORK_DIR}/docker"
# NOTE: docker-compose.yaml no longer contains ${VERSION} — the ente-io/server
# image is pinned to :latest because ghcr.io/ente-io/server does not publish
# semver tags (only :latest and commit SHAs).  The VERSION env var is still
# propagated for fpk metadata (filename, manifest, release notes).
cp "${SCRIPT_DIR}/../../../apps/ente/fnos/docker/docker-compose.yaml" "${WORK_DIR}/docker/"
cp -a "${SCRIPT_DIR}/../../../apps/ente/fnos/ui" "${WORK_DIR}/ui"

cd "${WORK_DIR}"
tar czf "${SCRIPT_DIR}/../../../app.tgz" docker/ ui/

echo "Built app.tgz for ente ${VERSION}"
