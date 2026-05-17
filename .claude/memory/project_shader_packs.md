---
name: Shader pack management — packwiz-tracked, update on major releases
description: Complementary + Euphoria Patches shader pipeline. How updates work, what to check before a major release, and how the export bundles zips.
type: project
---

## How shader packs are tracked

Three coupled pieces, all updated together:

1. **Euphoria Patches** — `mods/euphoria-patches.pw.toml` (NeoForge mod, tracked via Modrinth `mod-id = "4H6sumDB"`). Update with `packwiz update euphoria-patches`.
2. **Complementary Reimagined** — `shaderpacks/complementary-reimagined.pw.toml` (Modrinth `mod-id = "HVnmMxH1"`). Update with `packwiz update complementary-reimagined`.
3. **Complementary Unbound** — `shaderpacks/complementary-unbound.pw.toml` (Modrinth `mod-id = "R6NEzAwj"`). Update with `packwiz update complementary-unbound`.

The Euphoria Patcher version dictates the required Complementary version: `EuphoriaPatcher-X.Y.Z-rN.M-neoforge.jar` requires Complementary `rN.M` as the base. **They must move together.**

## Local zips are bundled-only

`shaderpacks/*.zip` files exist locally so `scripts/export.sh` can bundle them into the self-contained client zip. They are:
- Excluded from packwiz via `.packwizignore` (`shaderpacks/*.zip`) — tracked via pw.toml metadata only, no double-tracking
- Excluded from git via `.gitignore` (`shaderpacks/*.zip`) — too large for git history
- Downloaded on demand by `export.sh` from each pw.toml's URL when missing — so fresh clones can still build the client zip without manual setup

The `shaderpacks/*.pw.toml` metadata files ARE in git. The mrpack distribution downloads zips via the pw.toml URLs at install time.

After updating a shader pack via `packwiz update`, you can pre-download the zip with `curl` if you want it cached for faster export, but it's not required — export.sh handles it.

## Default shader pack reference

`server/content/config/iris.properties` sets `shaderPack=ComplementaryReimagined_<base> + EuphoriaPatches_<patch>`. Bump these strings to the new versions when shaders update or the pack name in-game won't match the patched output and shaders silently fall back to off.

## Update notifications disabled

`server/content/config/euphoria_patcher/settings.toml`:
- `doUpdateChecking = "none"` — disables the popup that fires every launch
- `doDisplayShaderInGameMessage = false` — disables the in-game shader's own update banner

Re-enable temporarily if checking for updates manually, then restore.

## Pre-major-release checklist

Before cutting any 1.x.0 release:
1. `packwiz update euphoria-patches` — check for new Euphoria Patcher version
2. If Patcher updated, `packwiz update complementary-reimagined` and `packwiz update complementary-unbound` to the matching `rN.M` base version
3. Re-download zips into `shaderpacks/` (delete the old ones)
4. Update `iris.properties` shader pack name to match new versions
5. Test launch — confirm shaders compile cleanly
