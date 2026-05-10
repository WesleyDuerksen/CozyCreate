---
name: Homestead + AoCA study — completion state
description: What was completed in both modpack studies and where CozyCreate mod selection stands
type: project
originSessionId: 5cd97d02-d633-4c91-8b3e-7cbb4133d9f0
---
## Homestead Study (complete)

All 5 phases complete. Files in `/Users/wesley/Documents/CozyCreate/research/homestead-phase*.md`.

- Phase 1: Full 376-mod inventory, categorized + NeoForge compat checked
- Phase 2: Emotional jobs mapping, 5-layer cozy stack identified
- Phase 3: NeoForge gap analysis (~90% high-value mods confirmed)
- Phase 4: ~120-mod shortlist (`homestead-phase4-shortlist.md`) with confirmed Modrinth slugs
- Phase 5: Design rationale

---

## AoCA Study (complete)

All 5 phases complete. Files in `/Users/wesley/Documents/CozyCreate/research/aeronautics-phase*.md`.

Source: Local install of AoC Aeronautics v1.4 in PrismLauncher (`/Users/wesley/Library/Application Support/PrismLauncher/instances/Aoc Aeronautics-v1.4/`).

- Phase 1: Full ~170-mod inventory from local mods folder + modlist.html
- Phase 2: Delta analysis — Column B (~87 candidates not in our shortlist)
- Phase 3: Fit filter — 57 Add, 19 Skip, 1 swap (all Investigate items resolved)
- Phase 4: Augmented shortlist update (`aeronautics-phase4-shortlist-update.md`) — 68 new additions, 2 swaps, 1 removal
- Phase 5: Design rationale (`aeronautics-phase5-design-rationale.md`)

### Key decisions from AoCA study
- **Transport philosophy extended**: not just no teleportation, but no systems that resolve transport problems *for* the player. Cuts: Hypertubes, Package Couriers, Mobile Packages, Ornithopter, Trading Floor.
- **Power**: Power Grid is the only electricity system. New Age and Crafts & Additions (RF/FE) both cut.
- **Confectionery cluster cut**: Café, Chocolate Fountain, Confectionery, Mechanical Confection all removed. Rely on Homestead food layer (HerbalBrews, Vinery, etc.).
- **Rails**: Keep Steam 'n' Rails + add Blocks & Bogies and Train Parts on top. Navigator replaces Track Map.
- **Audio swap**: Sodium Dynamic Lights replaces LambDynamicLights (better Sodium/Embeddium integration).
- **Biome Music skipped**: library only, inert without AoCA's custom resource pack.
- **Create decoration layer added**: Industrialized Architecture, Design n' Decor, Sound of Steam, Vibrant Vaults, Prismatic Shine, Fantasizing Again — fills the gap between cozy furniture and raw machinery.
- **Trusted server**: Aeronautics Claims and Open Parties and Claims both cut.

### Swaps applied to Phase 4 shortlist
- LambDynamicLights → Sodium Dynamic Lights
- Create: Track Map → Create Railways Navigator

---

## Install Progress

- Phase 1 (Create Core) ✅
- Phase 2 (Create Addons) ✅
- Phase 3 (Decoration & Ambience from Homestead shortlist) ✅ — 88 total mod entries, server gate passed
- Phase 4 (Adventure & World) — not yet started
- Phase 5 (QoL & Performance) — not yet started

## Notes from Phase 3

- `oculus` only goes to 1.20.1; use `iris` for NeoForge 1.21.1 shaders instead
- Official Sodium NeoForge (`sodium`) is the right dep for sodium-dynamic-lights, not `embeddium`
- `decorative-lamps` is a Fabric mod running via Sinytra Connector; server skips it safely, client loads it
- `geckolib` and `yacl` are deps that packwiz doesn't auto-detect (must add manually)
- validate.sh requires `--side server` flag on packwiz-installer-bootstrap call (fixed in Phase 3)

**Why:** Phase 3 was decoration/ambience. Phase 4 is adventure/world gen from the shortlist.
