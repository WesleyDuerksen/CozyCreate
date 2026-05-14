---
name: Config source of truth is server/content/config/ — except Patchouli books
description: Root config/ is gitignored and regenerated; authored config (mod configs etc.) lives in server/content/config/. Patchouli books are an exception — they must be data packs, not config.
type: project
---

The repo has two config directories and they are not symmetric:

- `server/content/config/` — git-tracked, **the source of truth**. Edit here.
- `/config/` (repo root) — gitignored (`.gitignore:29`), **regenerated every export**. `scripts/export.sh` does `rm -rf config && cp -r server/content/config config` before refreshing packwiz. Anything written here is lost on the next export and never reaches git or the shipped pack.

**Why:** Single-source-of-truth pattern — the server is canonical, the client/distribution side is derived.

**How to apply:**
- All authored config (mod config edits, etc.) goes in `server/content/config/`.
- Never write directly to root `/config/` — it's an artifact directory.

## Patchouli books — EXCEPTION

See `reference_patchouli_books.md` for full architecture. Short version:

- Source of truth: `server/content/patchouli_books/guide/` (copied to `.minecraft/patchouli_books/` by export.sh)
- Book ID: `patchouli:guide` (namespace is always `patchouli` for external books; the folder name is the path)
- Give command: `/give @p patchouli:guide_book[patchouli:book="patchouli:guide"]`
- KubeJS data and resource packs do NOT work for this — only the filesystem external books folder works.
