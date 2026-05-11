---
name: Verify a mod is actually installed before flagging a design conflict
description: Before raising a "this conflicts with the design" call about a mod's config, check /mods/ to confirm it's actually in the pack — plan.md notes can be stale
type: feedback
originSessionId: d9fde917-300f-4c7a-bab0-5643a5249f85
---
When reviewing a config and spotting what looks like a design conflict (e.g. jetpacks vs "Aeronautics is the only aerial travel"), **always verify the mod is actually installed** before raising the flag. Don't assume `plan.md` notes like "skipped — no 1.21.1 NeoForge" are still accurate; the user installs mods as they become available and the plan may not be updated synchronously.

**Why:** During Tier 3 Create Addons review I almost dismissed Create: Stuff 'n Additions configs as stale based on a plan.md "skip" note from 2026-05-08 — but the mod was actually installed. Conversely, several other configs (offroad, base Create: Simulated) ARE stale because those mods aren't installed. The check is fast and cheap.

**How to apply:**
1. Before flagging a conflict from a config, run `ls /home/kavikick/Documents/CozyCreate/mods/ | grep -i <mod-slug>` (or equivalent).
2. If installed → take the design call seriously, present findings to user.
3. If not installed → note it as a stale config in the tracker but don't agonize over its contents.
4. The mods that have configs but aren't installed at time of writing: `offroad-server.toml`, `simulated-server.toml` (base Simulated, not the Dragons+ extension). Leftover from earlier exploration; safe to mark stale.
