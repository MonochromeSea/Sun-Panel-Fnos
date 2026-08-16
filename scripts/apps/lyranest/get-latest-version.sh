#!/bin/bash
set -euo pipefail

INPUT_VERSION="${1:-}"

# Upstream release tags carry a "v" prefix (v0.2.4); the GHCR image tag does not.
TAG=$(curl -sL "https://api.github.com/repos/WHWgogogo/LyraNest/releases/latest" | \
  jq -r '.tag_name')

if [ -n "$INPUT_VERSION" ]; then
  VERSION="$INPUT_VERSION"
else
  VERSION=$(echo "$TAG" | sed -E 's/^v//')
fi

[ -z "$VERSION" ] || [ "$VERSION" = "null" ] && { echo "Failed to resolve version for lyranest" >&2; exit 1; }

echo "VERSION=$VERSION"

if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "version=$VERSION" >> "$GITHUB_OUTPUT"
fi
