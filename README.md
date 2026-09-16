# cs-image-system-testconfig — the live configuration

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
[configuration reference](https://github.com/infrastructurebuilder/cs-image-system-3/blob/develop/docs/CONFIGURATION.md).

## How it is driven

Check it out **beside** `cs-image-system-3` (the default), or point
`CSIS_CONFIG_ROOT` at it. From the system repository:

```sh
just cli validate                 # the tree against every rule
just v2-dry-run                   # headless dry run --all: generation + the enumerated applies
just cloud-preflight              # reality matches meta-state (state query --strict)
just gce-cycle                    # a real GCE change cycle, committed here
```

`cfg/_config.yml` declares `module_source_base: ../cs-image-system-3/tfmodules`:
the terraform modules stay in the system repository and are reached from
this checkout by that relative path, so the two repositories sit side by
side (or the value names wherever the modules are). The system's CI reads
this repository's `develop` branch.

## What a run writes here

Every run writes `meta-state/` (read-models, lineage, pins, launch
parameters, the run journal) and regenerates `generated/<lifecycle>/`,
including one self-contained `run-<lifecycle>.sh` per lifecycle. With
`--commit` the run commits exactly those two trees into this repository —
generated IaC included, by design — and pushes nothing; pushing is the
operator's act. `.gitignore` keeps only tool residue out of that commit
(`.terraform/`, plans, state files).

## Credentials, secrets and people

Credentials arrive through the environment only and are never in this
repository: an AWS session for the `noaa` profile, application-default
credentials for GCP, the OPA API pair as `TF_VAR_<team>_key` and
`TF_VAR_<team>_secret`, the Okta API key as `OKTA_API_*`, and the age
identity that opens the encrypted values as `CSIS_CONFIG_IDENTITY`. An
operator keeps them in a `.envrc` that is ignored here; the full contract
is the system's [operating manual](https://github.com/infrastructurebuilder/cs-image-system-3/blob/develop/docs/OPERATIONS.md).

The user and group rosters under `groups/` are encrypted entry by entry
(`ENC[age:...]`) to the recipients listed in `cfg/_config.yml`; the system
decrypts them at load and the emitted IaC carries only the ciphertext,
decrypting at plan time. Addresses derived from a username by the
configured template are public by construction.

## No overlays

The live configuration carries **no overlay files**: a transient
undeclare is `--undeclare instance:<name>` on the command line (what
`just gce-decommission` passes), and an overlay does nothing unless an
invocation names one anyway. The tests of `cs-image-system-3` never read
this tree; they own a frozen, synthetic copy under `tests/fixtures/config/`.

## Public-safe by construction

Every commit here is gated: `.githooks/pre-commit` runs
`cs-image-system public-safe --staged`, which refuses keys, tokens, PEM
bodies, an age identity, a service-account file, plans and state by name,
and, outside prose, addresses and long tokens. Install it once with
`just hooks-live` from the system repository (`git config core.hooksPath
.githooks`); scan the whole tree with `just public-safe-live`. What the gate
may let through is listed by decision, with the reason, in `cfg/_config.yml`
`public_safe.allow`, never by bypassing the hook. Encrypted values and the
emission's references to them pass by structure.

## Licence

Apache-2.0 ([LICENSE](LICENSE)), copyright Mykel Alvis; every file is
declared in [REUSE.toml](REUSE.toml).
