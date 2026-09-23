#!/usr/bin/env bash
# cs-image-system lifecycle runner: identity
# run id: 2026_09_23t09_10_20_024916
# Deferred commands accumulated while generating this lifecycle,
# in phase order. Paths are relative to this lifecycle's directory.
# state: workspace oktagroups -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/oktagroups.tfstate
# state: workspace okta-tf-users -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/okta_tf_users.tfstate
# NOTE: builders' pre/post finalize hooks are NOT part of this
# script; a --no-dry-run run performs them in-process.
set -euo pipefail
cd "$(dirname "$0")"
CSIS_ROOT="$(cd "../.." && pwd)"   # the configuration root, relative to this script

# --- phase: group-generation ---
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && rm -f tfplan )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu init -input=false -reconfigure -backend-config=oktagroups-group-generation.tfbackend.hcl )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system --root-dir "$CSIS_ROOT" --no-dry-run state-migration backup --workspace oktagroups --tofu /usr/local/bin/tofu --run 2026_09_23t09_10_20_024916 )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu state rm module.group_stofs.oktapam_user_group_attachment.members["mykel.alvis"] )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu plan -input=false -out=tfplan )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system gate-plan --planfile tfplan --tofu /usr/local/bin/tofu )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system apply-check --lifecycle identity --root oktagroups )
( cd "oktagroups/group-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu apply -input=false tfplan )
