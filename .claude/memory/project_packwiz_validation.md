---
name: Packwiz validation workflow and debugging
description: How validate.sh works (Docker-based), known issues, false-positive log patterns
type: project
originSessionId: b9be44d2-2eda-41f8-8f08-179adfedd8e4
---
## Running the server smoke test

```bash
./scripts/validate.sh
```

Run from the repo root. validate.sh is Docker-based: it ensures missing Modrinth mods are downloaded into `server/content/mods/`, runs `docker compose up -d minecraft` in `server/`, polls the container healthcheck until `healthy` (timeout 600s, since mod loading is slow), parses `server/data/logs/latest.log` against `KNOWN_OK_PATTERNS`, then `docker compose down`. No more direct NeoForge launch on the host.

**Requires:** docker daemon access. If `docker version` fails with permission denied, add your user to the `docker` group and re-login, or run validate.sh with sudo.

**RCON password:** validate.sh auto-generates `server/rcon-password.txt` if missing (read by the compose stack via Docker secrets).

## Mod sourcing

- Modrinth mods: validate.sh downloads them via the `url = ` field in each `mods/*.pw.toml` directly into `server/content/mods/`. Cached jars are skipped.
- CurseForge mods (no `url = ` in the toml): must be placed in `server/content/mods/` manually. validate.sh fails fast if any are missing.

## Known false-positive error patterns (KNOWN_OK_PATTERNS in validate.sh)

- `RuntimeDistCleaner/DISTXFORM` — client-only classes scanned on server, NeoForge filters them
- `Native backend failed to load` — Power Grid native lib unavailable on macOS, falls back to software
- `loot_table.*railways:blocks/track_` — Steam 'n' Rails compat tables for BYG/Nature's Spirit (not installed yet)
- `Unknown registry key.*railways:track_` — same as above
- `Reference map.*veil.refmap.json` — Veil rendering lib (bundled in Aeronautics) has client-only mixin maps
- `Fabric API detected.*Moonlight` — Moonlight Lib cosmetic ERROR when Sinytra Connector is present
- `Couldn't parse element.*beautify:blocks/` — Beautify 2.0.2 malformed loot table format
- `Parsing error loading recipe create:crafting/kinetics/` — Create 6.0.10 gearbox recipe format mismatch
- `Parsing error loading recipe dndesires:crafting/` — Dreams & Desires omni_gearbox recipe format mismatch
- `is a Fabric mod and cannot be loaded` — Decorative Lamps jar skipped on server, loads via Connector client-side

(Full list is in validate.sh — keep that authoritative.)

## Steam 'n' Rails: pinned to v0.1.0

0.2.0-beta.2 crashes the server with `Entity railways:conductor has no attributes` → cascades into Create's RegisterEvent → fatal crash. v0.1.0 is stable. Do not upgrade without testing.

## Prism bootstrap debugging

If the Prism pre-launch bootstrap only downloads CLAUDE.md or shows "(1/1)":
1. Delete the stale `packwiz.json` in the Prism instance's `.minecraft/` folder
2. Delete any stale `CLAUDE.md` from the same folder
3. If still wrong: bump `version` in `pack.toml`, run `packwiz refresh`, commit and push — forces GitHub CDN cache invalidation
4. Root cause was GitHub CDN serving stale pack.toml to the installer while WebFetch hit a different (updated) CDN node

## .packwizignore is required

Without `.packwizignore`, `packwiz refresh` sweeps everything into the index. The ignore file lives at `.packwizignore` in the repo root and excludes all non-mod content.

**Always run `./scripts/validate.sh` before committing** — do not commit immediately after `packwiz refresh`. The validate run catches hash errors and confirms the server still starts cleanly.

**Repo structure — ignored by packwiz via directory entries:**
- `docs/` — planning, config-review, research, audit docs
- `scripts/` — export.sh, release.sh, validate.sh
- `assets/` — icon.png, server-icon.png (plus `*.png`/`*.jpg` catch-all)
- `server/` — covers both `server/content/` (authored pack) and `server/data/` (instance state)
- `build/`, `.claude/` — artifacts, memory

**After adding new files outside `mods/` or `config/`, verify `.packwizignore` covers them** before running `packwiz refresh` — any unignored file gets swept into the index and causes hash errors on client installs.
