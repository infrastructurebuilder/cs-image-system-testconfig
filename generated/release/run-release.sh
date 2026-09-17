#!/usr/bin/env bash
# cs-image-system lifecycle runner: release
# run id: 2026_09_17t06_18_00_699014
# Deferred commands accumulated while generating this lifecycle,
# in phase order. Paths are relative to this lifecycle's directory.
# NOTE: builders' pre/post finalize hooks are NOT part of this
# script; a --no-dry-run run performs them in-process.
set -euo pipefail
cd "$(dirname "$0")"
CSIS_ROOT="$(cd "../.." && pwd)"   # the configuration root, relative to this script

# --- phase: instance-generation ---
( cd "release" && cs-image-system --root-dir "$CSIS_ROOT" --no-dry-run release --declared )
