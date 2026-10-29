# Where each package comes from

Rule, set 2026-10-29: a tool comes from nixpkgs when the rev `flake.lock` pins
offers the same or a newer version than Homebrew; otherwise it goes in
`homebrew.brews` or `homebrew.casks`. Dependency-only formulae are never
declared; they arrive with their parents.

Versions below are nixpkgs at rev `9387b3f` (locked 2026-09-03) against
`brew info` on 2026-10-29. Tap formulae use the version in the local tap clone.
Reasons appear only where the choice was not the mechanical result of the rule.

## nixpkgs (`home.packages` in `home.nix`)

| package | nixpkgs | Homebrew or other source | reason |
|---|---|---|---|
| actionlint | 1.7.12 | 1.7.12 | |
| asciinema-agg | 1.9.0 | cargo 1.4.3 | |
| bacon | 3.25.0 | cargo 3.8.0 | |
| bottom | 0.14.9 | cargo 0.10.2 | |
| cargo-binstall | 1.22.0 | cargo 1.15.7 | |
| cargo-dist | 0.32.0 | cargo 0.22.1 | |
| dioxus-cli | 0.7.10 | cargo 0.7.9 | |
| gh | 2.99.0 | 2.103.3 | kept in nix on the 2026-10-29 call so the fleet's `gh-axi` runs on a nix-provided `gh`; Homebrew is newer, revisit at the next `nix flake update` |
| git-cliff | 2.14.1 | cargo 2.5.0 | |
| git-filter-repo | 2.47.0 | uv tool 2.47.0 | |
| hubble | 1.19.4 | hand-placed 1.16.0 | |
| kubernetes-helm | 4.2.4 | helm 4.3.1, helm@3 3.20.1 | Helm 3 is retired; `helm` must resolve to Helm 4 at once, which only a nix declaration does while `helm@3` is still linked |
| minio-client | 2025-08-13 | minio/stable/mc 2025-08-13 | |
| nodejs | 24.19.0 | node 26.12.1 | kept in nix on the 2026-10-29 call so the five axi tools run on a nix-provided `node`; Homebrew is newer, revisit at the next `nix flake update` |
| openssl | 3.6.3 | openssl@3 3.5.9 | provides the `openssl` command; Homebrew's copy stays as a dependency of 28 formulae |
| operator-sdk | 1.42.3 | 1.42.3 | |
| p7zip | 17.06 | 17.06 | |
| release-plz | 0.3.160 | cargo 0.3.91 | |
| remake | 4.3+dbg-1.6 | 4.3-1.6 | |
| sshpass | 1.10 | hudochenkov/sshpass 1.06 | |
| tree | 2.3.2 | 2.3.2 | |
| vals | 0.46.0 | hand-placed 0.46.0 | |
| wget | 1.25.0 | 1.25.0 | |

`~/.cargo/bin`, `~/.local/bin` and `/usr/local/bin` sit ahead of the nix
profile on PATH, so the cargo, uv and hand-placed copies above keep winning
until they are removed. Removal is a separate task.

## Homebrew (`homebrew.brews` and `homebrew.casks` in `configuration.nix`)

| package | nixpkgs | Homebrew | reason |
|---|---|---|---|
| ansible | 2.21.3 | 14.5.0 (core 2.21.5) | |
| awscli | 2.35.11 | 2.38.6 | |
| bash | 5.3p15 | 5.3.20 | |
| cloudflared | 2026.8.2 | 2026.10.4 | |
| ctlptl | 0.9.5 | tilt-dev/tap 0.9.6 | |
| docker-compose | 5.4.0 | 5.6.1 | |
| docker-mac-net-connect | none | chipmk/tap 0.1.7 | |
| git-lfs | 3.7.1 | 3.8.1 | |
| gnu-tar | 1.35 | 1.35 | nixpkgs installs it as `tar`, which would shadow macOS tar for every script; Homebrew installs `gtar` |
| gnupg | 2.4.9 | 2.5.24 | |
| helmfile | 1.7.4 | 1.8.2 | |
| herdr | 0.8.2 | 0.9.5 | |
| imagemagick | 7.1.2-29 | 7.1.2-34 | |
| iproute2mac | 1.7.2 | 1.7.6 | |
| kcat | 1.7.1 | 1.7.0 | nixpkgs is newer, but its libserdes dependency fails to compile on aarch64-darwin at the pinned rev |
| krew | 0.5.0 | 0.5.0 | the nixpkgs build ships only `krew`, no `kubectl-krew`, so `kubectl krew` would break once the Homebrew copy goes |
| kubectl-radar | none | 1.18.2 | |
| msodbcsql18 | none | microsoft/mssql-release 18.7.1.1 | |
| mysql | mysql84 8.4.11 | 26.10.0 (9.5.0 installed) | captain's call: stays on Homebrew with its data in `/opt/homebrew/var/mysql` |
| packer | 1.15.4 | hashicorp/tap 1.16.2 | |
| pkgconf | 2.5.1 | 3.0.10 | `pkg-config` is now an alias of this formula |
| poetry | 2.4.1 | 2.5.1 | |
| poppler | 26.06.0 | 26.10.0 | |
| powershell | 7.6.5 | 7.6.9 | the formula; the duplicate cask 7.4.2 is not declared |
| prometheus | 3.14.0 | 3.15.1 | |
| python@3.12 | 3.12.14 | 3.12.16 | |
| python@3.13 | 3.13.15 | 3.13.18 | |
| render | render-cli 2.24.0 | 2.31.0 | |
| talosctl | 1.13.9 | siderolabs/tap 1.14.2 | |
| telnet | none standalone | 308 | nixpkgs ships telnet only inside inetutils, whose `ping` and `hostname` would shadow the macOS ones |
| terraform | 1.16.0 | hashicorp/tap 1.17.0 | |
| tfenv | 3.2.2 | 3.2.2 | the nixpkgs build ships a `terraform` shim that would shadow the Homebrew terraform |
| tfstate-lookup | none | fujiwara/tap 1.12.1 | |
| tilt | 0.37.6 | 0.37.8 | |
| vcluster | 0.35.1 | loft-sh/tap 0.37.4 | |
| x86_64-unknown-linux-gnu | none | messense/macos-cross-toolchains 15.2.0 | |
| 1password-cli (cask) | 2.39.0 | 2.41.1 | |
| session-manager-plugin (cask) | 1.2.792.0 | 1.2.896.0 | |

`homebrew.onActivation.cleanup` stays at its default. Activation installs what
is listed and removes nothing; a tool left off these lists is still a
removal decision for its owner.

## Already covered by an existing nix declaration

| Homebrew or other copy | covered by |
|---|---|
| azure-cli 2.68.0 | `azure-cli` 2.89.1 |
| libpq 17.2 | `postgresql` 18.6 |
| sops 3.9.0 | `sops` 3.13.3 |
| uv 0.9.4 in `~/.local/bin` | `uv` 0.12.5 |
| yq 4.44.3 | `yq-go` 4.53.3 |

## Stays where it is

No nixpkgs package and no Homebrew formula exist for these, or the only
nixpkgs copy is older with no Homebrew fallback.

| tool | lives in | reason |
|---|---|---|
| gh-axi, lavish-axi, chrome-devtools-axi, tasks-axi, quota-axi | npm under Homebrew's node | public on npm, absent from nixpkgs |
| treehouse, no-mistakes, cursor-agent | `~/.local/bin` | self-updating binaries, absent from nixpkgs |
| awsctl, eqxctl | `/usr/local/bin` | in-house, no public source |
| graphify | uv tool 0.9.76 | nixpkgs has 0.9.48, older, and there is no Homebrew formula |
| memsearch | uv tool | absent from nixpkgs |
| worker-build | cargo 0.8.7 | nixpkgs has 0.8.5, older, and there is no Homebrew formula |
| rperf3-rs, gt7_server | `~/.cargo/bin` | absent from nixpkgs; gt7_server was built by hand |
| grit | `~/.grit` | nixpkgs `grit` is a different project |
| kubectl-sniff | krew | absent from nixpkgs |
| determinate-nixd | `/usr/local/bin` | the Nix daemon itself |

## Deliberately not declared

The owner decides their removal separately; nothing here is used.

- Zero history uses, nothing depends on them: antigen, asciinema, autoconf,
  automake, coreutils, dcmtk, gcc, gifsicle, jaq, nmap, putty, samba.
- openssl@1.1: end of life, removed from nixpkgs.
- helm@3: retired in favour of Helm 4. The `helm` formula stays only as a
  dependency of helmfile and vcluster.
- teleport, tsh, tctl, tbot in `/usr/local/bin`: retired. This repository
  never referenced Teleport, RVM or SDKMAN, so there was nothing to remove.
- libtool and zlib: build-only, zero uses; they stay as dependencies of
  imagemagick and mysql.
- corepack: zero uses; it ships inside Homebrew's node.
- The powershell cask: a duplicate of the formula.
