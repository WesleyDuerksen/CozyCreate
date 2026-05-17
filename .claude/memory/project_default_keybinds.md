---
name: Default keybind overrides — options.txt approach and confirmed key IDs
description: How keybind defaults are shipped, the options.txt partial-override mechanism, and confirmed key binding IDs from a live instance.
type: project
---

## Mechanism

Default settings (including keybinds) live in `options.txt` at the pack root. Minecraft reads this file on launch, applies any keys it recognizes, fills in defaults for everything else, then writes a complete `options.txt` back. A partial file works — you only need to list the keys you want to override.

**CRITICAL: The file MUST start with `version:3955` (the Minecraft 1.21.1 data version).** Without this header, Minecraft 1.21.1 silently rejects the entire file as invalid format and regenerates from defaults — losing every override including basic vanilla settings like particles and guiScale. The version line has been mandatory in options.txt since Minecraft 1.10. Bump this number if upgrading Minecraft.

Format: `key_<bindingId>:<keyCode>`

Key codes use LWJGL3 format: `key.keyboard.minus`, `key.keyboard.y`, `key.keyboard.grave.accent`, `key.keyboard.backslash`, `key.keyboard.apostrophe`, `key.keyboard.equal`, `key.mouse.left`, etc. Use `key.keyboard.unknown` to unbind. All keys above verified working in CozyCreate-1.1.3 after launch.

## Confirmed binding IDs (verified from live 1.0.2 Prism instance)

| Mod | Binding ID | Default | Our override |
|-----|-----------|---------|--------------|
| Simple Voice Chat | `key_key.mute_microphone` | `key.keyboard.m` | `key.keyboard.minus` |
| Supplementaries | `key_supplementaries.keybind.quiver` | `key.keyboard.v` | `key.keyboard.y` |
| Simple Voice Chat | `key_key.hide_icons` | `key.keyboard.h` | `key.keyboard.grave.accent` |
| Curios | `key_key.curios.open.desc` | `key.keyboard.g` | `key.keyboard.j` |
| Quark | `key_quark.keybind.lock_rotation` | `key.keyboard.k` | `key.keyboard.backslash` |
| KubeJS | `key_key.kubejs.kubedex` | `key.keyboard.k` | `key.keyboard.f6` |
| Tom's Storage | `key_key.toms_storage.open_terminal` | `key.keyboard.b` | `key.keyboard.i` |
| Personality | `key_key.personality.sit` | `key.keyboard.z` | `key.keyboard.apostrophe` |
| Sophisticated Backpacks | `key_key.sophisticatedbackpacks.inventory_interaction` | `key.keyboard.c` | `key.keyboard.equal` |
| Vanilla | `key_key.saveToolbarActivator` | `key.keyboard.c` | `key.keyboard.f4` |
| Quark | `key_quark.keybind.variant_selector` | `key.keyboard.r` | `key.keyboard.period` (R was a real conflict — fires alongside Iris reload) |

User preference: avoid `key.keyboard.unknown` — every binding should have a reasonable key, even if niche. Use free function keys (F4/F6/F7/F8/F9/F10) and punctuation (`comma`, `period`) for low-frequency bindings.

## Known conflict that triggered this work

Antique Atlas opens with `key_key.antique_atlas.open:key.keyboard.m`. Simple Voice Chat mute defaulted to M — moved to `-` (minus).

## All key codes verified

All key codes in the table above were confirmed to round-trip correctly through Minecraft on launch in CozyCreate-1.1.3 — including the LWJGL3-derived names (`grave.accent`, `backslash`, `apostrophe`, `equal`) that weren't visible in the source 1.0.2 instance.
