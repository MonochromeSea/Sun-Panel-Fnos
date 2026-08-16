#!/bin/bash
# shellcheck disable=SC2317
set -euo pipefail

INPUT_VERSION="${1:-}"

if [ -n "$INPUT_VERSION" ]; then
  VERSION="$INPUT_VERSION"
else
  # ghcr.io/ente-io/server only publishes :latest and commit-SHA tags — no semver tags.
  # The docker-compose pins to :latest directly, so VERSION here is purely for fpk
  # metadata (filename, manifest).  Use a date-stamped sentinel so CI produces a
  # unique release tag per day.  See #139 for background.
  VERSION="latest-$(date +%Y.%m.%d)"
fi

[ -z "$VERSION" ] && { echo "Failed to resolve version for ente" >&2; exit 1; }

echo "VERSION=$VERSION"

if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "version=$VERSION" >> "$GITHUB_OUTPUT"
fi
