---
name: Keep docs/modList.md in sync with packwiz
description: docs/modList.md is the canonical mod list and must be updated whenever packwiz adds or removes a mod
type: feedback
---

Whenever a mod is added or removed via packwiz, immediately update `docs/modList.md`:
- Add new mods to the correct category with their side (B/C/S) and a one-line description
- Remove the row when a mod is dropped

**Why:** The user explicitly asked for this as an actively-maintained document because "mod drift" makes stale lists useless. The instruction is also baked into CLAUDE.md so it applies to all future conversations.

**How to apply:** Treat it like updating a lockfile — it's a required step every time packwiz changes the mod roster, not optional documentation.
