---
name: WATUT requires Iris shaders enabled — do not flip enableShaders to false
description: WATUT mod 1.2.7 (latest for NeoForge 1.21.1) crashes on launch when Iris enableShaders=false; we must ship with shaders on.
type: project
---

`config/iris.properties` MUST have `enableShaders=true`. Flipping it to `false` will crash the game on launch with `Invalid shaders/core/particle.json: File not found`.

**Why:** WATUT (What Are They Up To, `watut-neoforge-1.21.0-1.2.7.jar`) ships a `GameRendererReloadShaders` mixin that tries to load shader resources unconditionally — it doesn't check whether Iris shaders are enabled first. When `enableShaders=false`, the vanilla shader pipeline isn't fully initialized in the way WATUT expects, and the particle shader load throws. The crash was triggered going from 1.1.3 → 1.1.4 by exactly this config change.

The bug is unfixed in WATUT 1.2.7 (latest) and not filed on https://github.com/Corosauce/WATUT/issues.

**How to apply:**
- Leave `enableShaders=true` in `server/content/config/iris.properties`. Players can disable shaders in-game via Video Settings → Shader Packs.
- If a future version of WATUT fixes the shader check, the constraint can be re-evaluated.
- If WATUT is ever removed from the pack, this constraint goes away — re-evaluate the default at that point.
