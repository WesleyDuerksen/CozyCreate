## Notes
rm CozyCreate.zip && zip CozyCreate.zip -r client/

To get a server running 
- Clone
- cp -r client/minecraft/mods/ data/cp client/minecraft/
- docker compose up

## Understanding Version Numbers

Version numbers follow the format `MAJOR.CONTENT.CONFIG`.

| Digit | What changes | Example |
|-------|-------------|---------|
| **MAJOR** | Fundamental shifts in the pack's identity or philosophy — the kind of change that makes it a different pack. Renaming the cozy-engineering vision to something else, swapping the core aesthetic, or rebuilding the design constraints from scratch. | `1.x.x → 2.x.x` if the pack moved from steam/diesel-punk to a modern industrial theme |
| **CONTENT** | Mod additions or removals — anything that changes what is playable. Adding a new Create addon, cutting a decoration mod, swapping one world-gen mod for another. | `x.1.x → x.2.x` when a new mod is added or removed |
| **CONFIG** | Configuration changes only — no mods added or removed, just tuning the values. Tweaking durability, adjusting recipe costs, changing progression gates. | `x.x.0 → x.x.1` Changing how high jetpacks can fly |

A `CONTENT` bump resets `CONFIG` to `0`. A `MAJOR` bump resets both.
