#!/usr/bin/env bash
# cs-image-system lifecycle runner: instance-image
# run id: 2026_09_17t16_50_31_612963
# Deferred commands accumulated while generating this lifecycle,
# in phase order. Paths are relative to this lifecycle's directory.
# state: workspace tofu-gce -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/tofu_gce.tfstate
# NOTE: builders' pre/post finalize hooks are NOT part of this
# script; a --no-dry-run run performs them in-process.
set -euo pipefail
cd "$(dirname "$0")"
CSIS_ROOT="$(cd "../.." && pwd)"   # the configuration root, relative to this script

# --- phase: image-generation ---
( cd "pckr-gce-ans/image-generation/block-000" && /usr/local/bin/packer build . )

# --- phase: instance-generation ---
( cd "tofu-gce/instance-generation" && rm -f tfplan )
( cd "tofu-gce/instance-generation" && /usr/local/bin/tofu init -input=false -reconfigure -backend-config=tofu-gce-instance-generation.tfbackend.hcl )
( cd "tofu-gce/instance-generation" && /usr/local/bin/tofu plan -input=false -out=tfplan )
( cd "tofu-gce/instance-generation" && cs-image-system gate-plan --planfile tfplan --tofu /usr/local/bin/tofu )
