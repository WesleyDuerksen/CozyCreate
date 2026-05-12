---
name: Commit workflow — validate first, capture configs, check gitignore
description: Required steps before committing any mod install or pack change
type: feedback
originSessionId: fe85b186-9b56-401c-b345-ec51b80ed835
---
Always follow this sequence after adding or removing mods, before committing:

1. `packwiz refresh`
2. `./scripts/validate.sh` — must pass before staging anything
3. `git status server/config --short` — check for new config files from new mods; stage them
4. Check `.gitignore` for any leftover config folders from mods that were removed (e.g. waila/ from WTHIT)
5. Check `.packwizignore` if any new non-mod files were added to the project root — add them before the next refresh

**Why:** skipping validate led to a hash error landing in the pack. Missing config captures and leftover gitignore gaps have both been caught post-hoc. These checks are cheap and prevent follow-up commits.

**How to apply:** treat validate + config check as a hard gate, not optional cleanup.
