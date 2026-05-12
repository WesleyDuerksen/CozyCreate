---
name: SP is build-only on superflat worlds
description: Singleplayer's sole purpose is schematic prototyping on superflat; no exploration → server-only side classifications are safe for worldgen/QoL
type: project
originSessionId: cd32a8f2-d241-4509-a03d-39c19a4f72d8
---
Singleplayer in this pack exists only for building designs on superflat worlds, schematizing them, and reproducing in MP via the schematic cannon. There is no SP exploration use case.

**Why:** Confirmed by user 2026-05-12 during the client-mod-audit pass. The build-prototype → schematize → cannon-in-MP flow is the entire SP purpose.

**How to apply:**
- Worldgen content mods (structures, biomes, dungeons) can be `side = "server"` without concern — SP superflat doesn't need them.
- Server-side gameplay tweaks (right-click harvest, double doors, portal fix, crop growth) staying `side = "server"` is intentional, not an oversight.
- Block-registry parity between SP and MP only matters for mods that register blocks/items used in builds (Create family, decoration mods, etc.). Pure-data and pure-worldgen mods are exempt.
- Don't propose `server → both` flips for QoL mods on grounds of "SP parity."
