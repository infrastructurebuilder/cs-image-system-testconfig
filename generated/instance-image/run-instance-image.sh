#!/usr/bin/env bash
# cs-image-system lifecycle runner: instance-image
# run id: 2026_09_20t15_48_58_295637
# Deferred commands accumulated while generating this lifecycle,
# in phase order. Paths are relative to this lifecycle's directory.
# state: workspace open-tofu -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/open_tofu.tfstate
# NOTE: builders' pre/post finalize hooks are NOT part of this
# script; a --no-dry-run run performs them in-process.
set -euo pipefail
cd "$(dirname "$0")"
CSIS_ROOT="$(cd "../.." && pwd)"   # the configuration root, relative to this script

# --- phase: image-generation ---
( cd "pckr-ebs-ans/image-generation/block-000" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/packer build . )

# --- phase: instance-generation ---
( cd "open-tofu/instance-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && rm -f tfplan )
( cd "open-tofu/instance-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu init -input=false -reconfigure -backend-config=open-tofu-instance-generation.tfbackend.hcl )
( cd "open-tofu/instance-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu plan -input=false -out=tfplan )
( cd "open-tofu/instance-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system gate-plan --planfile tfplan --tofu /usr/local/bin/tofu )
( cd "open-tofu/instance-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system apply-check --lifecycle instances --root open-tofu --root-alias aws-east2-runtime --apply-runtime aws-east2-runtime )
( cd "open-tofu/instance-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu apply -input=false tfplan )
