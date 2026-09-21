#!/usr/bin/env bash
# cs-image-system lifecycle runner: storage
# run id: 2026_09_20t19_13_29_440651
# Deferred commands accumulated while generating this lifecycle,
# in phase order. Paths are relative to this lifecycle's directory.
# state: workspace aws-ebs -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/aws_ebs.tfstate
# state: workspace aws-efs -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/aws_efs.tfstate
# state: workspace aws-s3 -> s3://noaa-ioos-cloud-sandbox-tfstate/statefiles/csia-image-system-test/aws_s3.tfstate
# NOTE: builders' pre/post finalize hooks are NOT part of this
# script; a --no-dry-run run performs them in-process.
set -euo pipefail
cd "$(dirname "$0")"
CSIS_ROOT="$(cd "../.." && pwd)"   # the configuration root, relative to this script

# --- phase: storage-generation ---
( cd "aws-ebs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && rm -f tfplan )
( cd "aws-ebs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu init -input=false -reconfigure -backend-config=aws-ebs-storage-generation.tfbackend.hcl )
( cd "aws-ebs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu plan -input=false -out=tfplan )
( cd "aws-ebs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system gate-plan --planfile tfplan --tofu /usr/local/bin/tofu )
( cd "aws-ebs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system apply-check --lifecycle storage --root aws-ebs --root-alias aws-east2-runtime --apply-runtime aws-east2-runtime )
( cd "aws-ebs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu apply -input=false tfplan )
( cd "aws-efs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && rm -f tfplan )
( cd "aws-efs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu init -input=false -reconfigure -backend-config=aws-efs-storage-generation.tfbackend.hcl )
( cd "aws-efs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu plan -input=false -out=tfplan )
( cd "aws-efs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system gate-plan --planfile tfplan --tofu /usr/local/bin/tofu )
( cd "aws-efs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system apply-check --lifecycle storage --root aws-efs --root-alias aws-east2-runtime --apply-runtime aws-east2-runtime )
( cd "aws-efs/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu apply -input=false tfplan )
( cd "aws-s3/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && rm -f tfplan )
( cd "aws-s3/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu init -input=false -reconfigure -backend-config=aws-s3-storage-generation.tfbackend.hcl )
( cd "aws-s3/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu plan -input=false -out=tfplan )
( cd "aws-s3/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system gate-plan --planfile tfplan --tofu /usr/local/bin/tofu )
( cd "aws-s3/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && cs-image-system apply-check --lifecycle storage --root aws-s3 --root-alias aws-east2-runtime --apply-runtime aws-east2-runtime )
( cd "aws-s3/storage-generation" && cd "$(cs-image-system materialize . --root-dir "$CSIS_ROOT")" && /usr/local/bin/tofu apply -input=false tfplan )
