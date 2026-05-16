---
name: Mod removal checklist
description: All steps required when removing a mod from the pack
type: feedback
---

When removing a mod, complete all of these steps in order:

1. **Remove via packwiz**: `/home/kavikick/go/bin/packwiz remove <mod-slug>` from the pack root
2. **Update `docs/modList.md`**: Remove the mod's row and decrement the mod count in the header
3. **Delete leftover config files**: Search with `find . -name "*<modid>*"` and delete any config `.toml` files from:
   - `config/`
   - `server/content/config/`
   - `build/server/content/config/`
   - `build/client/.minecraft/config/`
4. **Delete leftover JAR files**: Remove the mod's `.jar` from:
   - `server/content/mods/`
   - `build/server/content/mods/`
   - `build/client/.minecraft/mods/`
5. **Run `scripts/validate.sh`** to confirm the server still starts clean

**Why:** Steps 3 and 4 are not handled by packwiz remove — it only deletes the `.pw.toml`. Leftover JARs and configs cause confusion and can cause the server to load a mod you thought you removed.
