#!/usr/bin/env bash
# cs-image-system lifecycle runner: retention
# run id: 2026_09_17t13_41_04_254494
# Deferred commands accumulated while generating this lifecycle,
# in phase order. Paths are relative to this lifecycle's directory.
# NOTE: builders' pre/post finalize hooks are NOT part of this
# script; a --no-dry-run run performs them in-process.
set -euo pipefail
cd "$(dirname "$0")"
CSIS_ROOT="$(cd "../.." && pwd)"   # the configuration root, relative to this script

# --- phase: instance-generation ---
( cd "retention" && cs-image-system --root-dir "$CSIS_ROOT" --no-dry-run dispose image --retention )
