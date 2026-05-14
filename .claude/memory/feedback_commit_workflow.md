---
name: Commit workflow — validate first, capture configs, check gitignore
description: Required steps before committing any mod install or pack change
type: feedback
originSessionId: fe85b186-9b56-401c-b345-ec51b80ed835
---
Always follow this sequence after adding or removing mods or files, before committing:

1. `packwiz refresh`
2. `./scripts/validate.sh` — must pass before staging anything
3. `git status server/content/config --short` — check for new config files from new mods; stage them
4. Check `.gitignore` — update for any new directories added to the project (e.g. `client/mods/*.jar`)
5. Check `.packwizignore` — update for any new directories/files that packwiz should not index; then run `packwiz refresh` again to flush stale index entries
6. Verify `index.toml` has no unexpected entries (grep for the new path to confirm it was excluded)

**Why:** skipping validate led to a hash error. Missing gitignore/packwizignore updates cause stale index entries (e.g. `client/mods/.gitkeep` and `client/mods/gpumemleakfix-1.21-1.8.jar` both got indexed when `client/` wasn't ignored). These checks are cheap and prevent follow-up commits.

**How to apply:** treat all six steps as a hard gate any time files are added, moved, or removed — not just when mods change.
