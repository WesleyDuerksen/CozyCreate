---
name: Two distribution formats — mrpack and client zip
description: The pack ships as both an mrpack and a self-contained client zip; they have different file inclusion rules and behave differently for overrides.
type: project
---

`scripts/export.sh` produces three artifacts:
- `build/CozyCreate-<version>.mrpack` — Modrinth-format pack; mods download at install time
- `build/CozyCreate-<version>.zip` — Self-contained Prism instance zip; all mods bundled
- `build/CozyCreate-<version>-server.zip` — Server bundle

## How overrides reach the client

**mrpack:** Only files listed in `index.toml` are included as overrides. They land at `.minecraft/<path>` matching their path relative to the pack root. A file at `config/foo.toml` → `.minecraft/config/foo.toml`. A file at `options.txt` → `.minecraft/options.txt`.

**client zip:** `export.sh` manually copies files in step 5. Currently handles: `config/`, `kubejs/`, `patchouli_books/`, `options.txt`, `servers.dat`, `shaderpacks/`.

## Critical: assets/ is packwiz-ignored

The `assets/` directory is in `.packwizignore` — files placed there will never be picked up by packwiz and never appear in the mrpack. `assets/` is only useful as a staging area for the client zip build (export.sh copies from it explicitly).

**For files that need to ship in both formats** (options.txt, servers.dat), put them at the **pack root** and track them in `index.toml`. They will be ignored by packwiz if placed in `assets/`.

## Current root-level override files

- `options.txt` — default client settings (particles, keybinds, sound, etc.)
- `servers.dat` — pre-populated multiplayer server list (binary NBT, copy from Prism instance)

Both are tracked in `index.toml` and excluded from `.packwizignore` (only `assets/` is excluded, not root-level files).

## packwiz refresh does NOT auto-discover new files

`packwiz refresh` only updates hashes for files **already in** `index.toml`. To add a new root-level file:
1. Add the `[[files]]` entry to `index.toml` manually with the sha256 hash
2. Run `packwiz refresh` to confirm/update
3. Verify with `grep <filename> index.toml`
