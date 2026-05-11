---
name: Jetpacks (Create Stuff 'n Additions) accepted as Create vocabulary
description: Resolution of the jetpacks-vs-Aeronautics design tension — jetpacks are kept at default heights and treated as fuel-gated Create tools, NOT a violation of the "Aeronautics only" rule
type: project
originSessionId: d9fde917-300f-4c7a-bab0-5643a5249f85
---
The "Aeronautics is the only aerial travel option" rationale in `research/homestead-phase5-design-rationale.md` and the README has a deliberate exception: **Create: Stuff 'n Additions jetpacks at default heights are accepted.**

**Why:** Resolved 2026-05-10 after explicit review. Jetpacks are fuel-gated Create tools — they require water/fuel/steam by tier, hold only 1600mB fuel (~5s thrust per tank), and require Create infrastructure to keep running. They're not waystone-tier shortcuts. The user explicitly chose "Accept defaults" after seeing tier breakdown:

- Andesite (height 18, heat fuel) — movement boost, basically jump tier
- Copper (height 18, hydraulic/water fuel) — slow movement
- Brass (height 28, steam fuel) — real flight; this is the one that competes most directly with Aeronautics
- Netherite (height 28, endgame) — Brass + lava swim

Aeronautics remains the milestone for sustained aerial transport because jetpack fuel burns so fast.

**How to apply:**
- Do NOT re-litigate jetpack config in future config reviews — the values in `create-stuff-additions.toml` are intentional
- If a future Phase 7+ playtest reveals jetpacks ARE replacing airships in practice, revisit then with playtest evidence, not config-review speculation
- This exception does NOT extend to other flight mods (Immersive Aircraft, Hypertubes, glider items) — those remain cut per rationale
