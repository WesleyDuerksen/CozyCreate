---
name: Packwiz validation workflow and debugging
description: How to run validate.sh, known issues encountered, and how to fix them
type: project
originSessionId: b9be44d2-2eda-41f8-8f08-179adfedd8e4
---
## Running the server smoke test

```bash
./validate.sh
```

Run from `/Users/wesley/Documents/CozyCreate`. First run installs NeoForge server automatically. Every run syncs mods via `file://` path to packwiz-installer-bootstrap, starts the server on port 25575, waits for `Done (` in logs, checks for errors/fatals, stops cleanly.

**Why port 25575:** dedicated test port to avoid conflicts with any real server on 25565.

## Before running run.sh directly (not via validate.sh)

Always kill port 25575 first — validate.sh does this automatically but run.sh does not:

```bash
kill $(lsof -ti :25575) 2>/dev/null
```

## Critical: --side server flag required

validate.sh calls packwiz-installer-bootstrap with `--side server`. Without this flag the installer uses `cachedSide` from `server/packwiz.json`, which can be "client" if you ever ran it without the flag. This causes client-only mods to be deployed to the server and crash it. If the flag was ever missing, delete `server/packwiz.json` to force a clean install, then re-run with the flag.

## Known false-positive error patterns (already in KNOWN_OK_PATTERNS in validate.sh)

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

## Steam 'n' Rails: pinned to v0.1.0

0.2.0-beta.2 crashes the server with `Entity railways:conductor has no attributes` → cascades into Create's RegisterEvent → fatal crash. v0.1.0 is stable. Do not upgrade without testing.

## Prism bootstrap debugging

If the Prism pre-launch bootstrap only downloads CLAUDE.md or shows "(1/1)":
1. Delete `/Users/wesley/Library/Application Support/PrismLauncher/instances/1.21.1/minecraft/packwiz.json`
2. Delete any stale `CLAUDE.md` from the same folder
3. If still wrong: bump `version` in `pack.toml`, run `packwiz refresh`, commit and push — forces GitHub CDN cache invalidation
4. Root cause was GitHub CDN serving stale pack.toml to the installer while WebFetch hit a different (updated) CDN node

## .packwizignore is required

Without `.packwizignore`, `packwiz refresh` sweeps everything into the index (research/, server/, CLAUDE.md, plan.md, etc.). The ignore file lives at `/Users/wesley/Documents/CozyCreate/.packwizignore` and excludes all non-mod files.

**Always run `./validate.sh` before committing** — do not commit immediately after `packwiz refresh`. The validate run catches hash errors and confirms the server still starts cleanly.

**After adding new .md files to the project root, add them to `.packwizignore` immediately** — `packwiz refresh` will sweep any unignored root-level file into the index, causing hash validation errors on client installs. Current ignored root files: `CLAUDE.md`, `plan.md`, `postInstall.md`, `config-review.md`, `validate.sh`.
