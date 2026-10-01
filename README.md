# cs-image-system-testconfig: the reference configuration

This repository is a configuration, not a program. It is the tree that
[cs-image-system](https://github.com/infrastructurebuilder/cs-image-system-3)
reads to build and run a cloud compute environment: the declarations under
`cfg/`, `groups/`, `images/`, `instances/` and `storages/`, the provisioning
content the images are baked with (`setup_*.yml`, `modify_image.yml`,
`mod_image.sh`, `playbooks/`), the infrastructure-as-code the system emits
from them under `generated/`, and the system's own records of what exists
under `meta-state/` (never edited by hand; see `meta-state/README.md`).
The environment it describes is the NOAA NOS coastal-modeling cloud
sandbox on AWS and GCE, with SSH access governed by Okta Privileged
Access. What each file and field means is in the system's
[configuration reference](https://github.com/infrastructurebuilder/cs-image-system-3/blob/develop/docs/CONFIGURATION.md);
how a team works with such a repository, from the first command on, is
its [daily driver](https://github.com/infrastructurebuilder/cs-image-system-3/blob/develop/DAILY_DRIVER.md).

It is also the system's REFERENCE configuration: the tree the system's own
live proofs run against, and the first repository ever written by
`cs-image-system init-config`.

## How it is driven

This repository stands alone (stage 64 of the system, 2026-09-26). The
parts a configuration repository needs beyond its YAML came from the
release through `cs-image-system init-config`, and are the release's byte
for byte:

| Part | What it is |
| --- | --- |
| `Justfile` | the single entry point: the five contract targets (`init`, `build`, `test`, `full-test`, `release`) and every daily and cycle recipe, each wrapping the `cs-image-system` command against this tree |
| `.github/workflows/ci.yml` | this repository's own CI: `verify` (no secrets), `live` (read-only against both clouds and OPA), `perform` (on `main`: the record, the guard on the GCE runtime, the performing run on `aws-east2-runtime` under the write role, the login proof as a workload, the closing record; records pushed back here) |
| `CI_SETUP.md` | how this repository's CI was set up, and how to set it up again from nothing: federation, the OPA workload objects, the secrets, the proofs (the release's, byte for byte) |
| `.github/workflows/opa-workload-probe.yml` | dispatch only: this repository's OIDC token presented to the team's workload connection |
| `.githooks/pre-commit` | the public-safe gate on every commit; `just init` installs it |
| `tfmodules/` | the terraform modules the emitted roots call, at `module_source_base: tfmodules` |
| `.gitignore` | the shell's exports, every credential file, the private mirror, tool residue; `generated/` and `meta-state/` ARE committed |
| `.csis-version` | the release that wrote these parts, which CI installs; move it when a new release is taken, then `cs-image-system init-config . --force` refreshes the parts |

The command comes from a release (`uv tool install cs-image-system`, or a
`pyproject.toml` depending on it with `CSIS="uv run cs-image-system"`).
Whoever develops the system drives this tree with the development
checkout instead: `export CSIS=<checkout>/.venv/bin/cs-image-system` (the
ignored `.envrc` here does that), or `just cli ...` from the system
repository, which points at this checkout beside it by default.

```sh
just init                          # the hook, the plugin cache, a check that the command runs
just validate                      # the tree against every rule
just dry                           # a dry run of every lifecycle: generated/ and the runner scripts
just cloud-preflight               # reality matches the records (state query --strict)
just cloud-cycle gcloud-east1      # the GCE change cycle, committed here (the operator's money)
just cloud-perform aws-east2-runtime
```

`just` alone lists every recipe, the contract first.

## What a run writes here

Every run writes `meta-state/` (read-models, lineage, pins, launch
parameters, the run journal) and regenerates `generated/<lifecycle>/`,
including one self-contained `run-<lifecycle>.sh` per lifecycle. With
`--commit` (`just record`, `just run ...`, the cycle recipes) the run
commits exactly those two trees into this repository, generated IaC
included, by design, and pushes nothing; pushing is the operator's act,
or CI's on `main`. `.gitignore` keeps only tool residue out of that commit
(`.terraform/`, plans, state files, the private mirror).

## What stands

The reference configuration keeps one durable machine on AWS and two EFS
filesystems, and the records in `meta-state/` are its memory; this
section is the human summary, revised when the machine changes (stages
72 and 73 of the system, 2026-09-30 and 2026-10-01).

- **`coops-model`** stands as `coops-model-005`: durable generation 5,
  alias `gar` (the pool's third live draw, after `cod` and `eel`), a
  `t3.medium` on `ami-06863fb35ff62f9ba` (the coops model image's third
  release). Its biography is `meta-state/instance-state.yaml`: generation
  3 (`coops-model-003`, alias `cod`) was resized in place twice on
  2026-09-30 (`c5n.4xlarge` to `t3.xlarge` to `t3.medium`, two `resized`
  events on the one generation, the same instance id throughout) and then
  decommissioned the same day; generation 4 (`coops-model-004`, alias
  `eel`) was raised from the same image with the same storages and proved
  the EFS data persisted, then decommissioned on 2026-10-01; generation 5
  was raised onto a different share.
- **`/mnt/efs` is `efs-scratch`** (`fs-09c4927fd6e539753`, declared
  2026-10-01, coops access point only): empty when the machine first
  mounted it. **`efs-storage`** (`fs-02d658f1561aab44b`, coops and stofs
  access points) is still declared and still holds everything it held --
  including `/ABC/DEF/here_we_are.txt`, the file stage 72 planted to prove
  persistence -- and is mounted by no machine. Its fate (keep as an
  archive, re-attach to something, or delete the entry and with it the
  filesystem) is the operator's decision, not yet taken.
- **`/mnt/data` is `mnt_data`** (`vol-0fe1e27716f86c2f2`, 100 GB,
  us-east-2a), attached to every generation so far; its contents came
  through each replacement.
- `gce-test` is declared `ephemeral: true` on `gcloud-east1` and stands
  only within a cycle run.

The strict state query (`just state-query --strict`) is the word on
whether this summary and reality agree; `main`'s `perform` job runs it
last, after logging in to the machine by its bare name.

## Branches and CI

`develop` is where the operator's cycles are committed and pushed; `main`
is what CI performs on. Every push runs `verify` and `live`; a push to
`main` (or a dispatch asking to record) runs `perform`, whose records are
pushed back to `main`. Each job is gated on the repository secrets it
names: none configured is SKIPPED and said so in the job summary, some
configured and some missing is a failure that names them. A green job is
not proof its steps ran; read the summary. The GCE runtime stays out of
CI by the cost decision (`GUARD_RUNTIME: gcloud-east1`): a declaration
change there fails `perform` before anything performs, and the operator
runs the GCE cycle by hand.

## Credentials, secrets and people

Credentials arrive through the environment only and are never in this
repository: an AWS session for the `noaa` profile, application-default
credentials for GCP, the OPA API pair as `TF_VAR_<team>_key` and
`TF_VAR_<team>_secret`, the Okta API key as `OKTA_API_*`, and the age
identity that opens the encrypted values as `CSIS_CONFIG_IDENTITY`. An
operator keeps them in a `.envrc` that is ignored here; CI reads them
from the repository secrets the workflow names; the full contract is the
system's [operating manual](https://github.com/infrastructurebuilder/cs-image-system-3/blob/develop/docs/OPERATIONS.md).

The user and group rosters under `groups/` are encrypted entry by entry
(`ENC[age:...]`) to the recipients listed in `cfg/_config.yml`; the system
decrypts them at load and the emitted IaC carries only the ciphertext,
which an execution materialises into the private mirror `_private/`
(never committed).

## No overlays

The live configuration carries **no overlay files**: a transient
undeclare is `--undeclare instance:<name>` on the command line, and an
overlay does nothing unless an invocation names one anyway. The tests of
`cs-image-system-3` never read this tree; they own a frozen, synthetic copy
under `tests/fixtures/config/`.

## Public-safe by construction

Every commit here is gated: `.githooks/pre-commit` runs
`cs-image-system public-safe --staged`, which refuses keys, tokens, PEM
bodies, an age identity, a service-account file, plans and state by name,
and, outside prose, addresses and long tokens. `just init` installs it
(`git config core.hooksPath .githooks`); `just public-safe` scans the
whole tree. What the gate may let through is listed by decision, with the
reason, in `cfg/_config.yml` `public_safe.allow`, never by bypassing the
hook. Encrypted values and the emission's references to them pass by
structure.

## Licence

Apache-2.0 ([LICENSE](LICENSE)), copyright Mykel Alvis; every file is
declared in [REUSE.toml](REUSE.toml).
