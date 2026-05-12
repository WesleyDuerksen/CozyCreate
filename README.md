# CozyCreate

A cozy, multiplayer-first Minecraft 1.21.1 (NeoForge) modpack where you are an **engineer in a cozy workshop**, not a farmer in a cottage.

> The cozy aesthetic isn't the goal — it's the container the engineering lives in.
> Every space should feel warm and lived-in, but the reason you're building those spaces is to house machines.

## The Thesis

Homestead's loop is: tend your farm, cook your food, decorate your home. That's the point.
CozyCreate's loop is: **automate** the farm, **automate** the food supply, then use the time and resources that frees up to build bigger, fly farther, and make your space more beautiful.

CozyCreate is built on a single design tension: **engineering depth vs. creative agency**. Every mod is filtered against one question:

> Does this give the player something to engineer, or does it engineer for them?

Mods that hand the player a solved system are cut. Mods that give the player tools to solve their own problems are kept. This filter is why Package Couriers, Trading Floor, Hypertubes, Immersive Aircraft, and the Confectionery cluster are all out — they each *resolve* a problem the game is supposed to *give* you.

## What CozyCreate Is

| Layer | Purpose |
|-------|---------|
| **Engineering spine** | Create + Diesel Generators + Power Grid + Aeronautics + Steam 'n' Rails. The reason to play. |
| **Cozy container** | Supplementaries, Handcrafted, Chipped, Farmer's Delight, AmbientSounds, Sound Physics. Makes engineering spaces feel like places. |
| **Industrial decoration** | Bells & Whistles, Create Deco, Design n' Decor, Sound of Steam, Vibrant Vaults. Makes a workshop read as a workshop. |
| **World worth flying over** | Tectonic, the YUNG's suite, Towns and Towers, Regions Unexplored, Serene Seasons. Reasons to build expeditions. |
| **Social food culture** | Let's Do Vinery, HerbalBrews, Farmer's Delight, Comforts. Cooking is a ritual, not a chore. |
| **Multiplayer infrastructure** | Simple Voice Chat, FTB Teams, FTB Quests. Rewards building shared systems. |

## Core Constraints

These are not preferences. They are the constraints that hold the pack together. Future additions are evaluated against them.

### 1. No teleportation. No shortcut travel.

Travel is tiered by engineering investment:

| Tier | Mode | Requirement |
|------|------|-------------|
| 0 | Walking / horse | Nothing |
| 1 | Rail network | Build Create: Steam 'n' Rails infrastructure |
| 2 | Airship | Build a Create: Aeronautics vehicle |

No Waystones. No Via Romana. No teleport scrolls. No glider items. No Hypertubes. A player who invests in a rail network genuinely moves faster than one who hasn't, and the rail network they build benefits the whole server. **Transport is progression.**

### 2. One power ecosystem. Create's own.

| Tier | Source |
|------|--------|
| Early | Waterwheels, windmills |
| Mid | Diesel generators |
| Late | Power Grid (Create's electrical layer) |

No RF/FE bridges. Create: New Age and Crafts & Additions are both cut. Power Grid was chosen *because* it extends Create's stress system rather than connecting to an outside standard. Adding an RF bridge invites RF consumers, which dilutes the engineering identity.

### 3. Stability over content.

Every mod is here for a specific reason. The pack is **curated, not kitchen-sink**. Pam's HarvestCraft 2 is out (1000+ foods would trivialize the food automation loop). AlcoCraft+ is out (redundant with Let's Do Vinery). Mods are pinned to exact versions.

### 4. Multiplayer-first, trusted server.

The server is played by people who know and respect each other. **No claims, no chunk protection, no anti-grief.** Those add complexity with no benefit on a trusted server.

What stays:
- **No Chat Reports** — privacy from Mojang's reporting system, not policing players
- **Simple Voice Chat** — proximity voice makes collaborative engineering real
- **FTB Quests** — a shared progression guide, not an enforcement tool

### 5. Cozy is not optional, but engineering is the point.

The decoration and ambience layer exists so engineering builds feel warm, not industrial-cold. A steam boiler should look like it belongs in a Victorian workshop, not a grey concrete cube. But the workshop houses machines. The kettle is in the corner.

## Build & Test

- **Format:** packwiz (git-tracked, version-pinned) → Modrinth `.mrpack`
- **Minecraft:** 1.21.1 / **Loader:** NeoForge 21.1.228
- **Server validation:** `./scripts/validate.sh` — boots a NeoForge server with the live pack, checks logs for fatals
- **Build plan:** see `docs/plan.md` for phase-by-phase mod additions
- **Design rationale:** see `docs/research/homestead-phase5-design-rationale.md` and `docs/research/aeronautics-phase5-design-rationale.md`
- **Config tracker:** see `docs/config-review.md`

## Understanding Version Numbers

Version numbers follow the format `MAJOR.CONTENT.CONFIG`.

| Digit | What changes | Example |
|-------|-------------|---------|
| **MAJOR** | Fundamental shifts in the pack's identity or philosophy — the kind of change that makes it a different pack. Renaming the cozy-engineering vision to something else, swapping the core aesthetic, or rebuilding the design constraints from scratch. | `1.x.x → 2.x.x` if the pack moved from steam/diesel-punk to a modern industrial theme |
| **CONTENT** | Mod additions or removals — anything that changes what is playable. Adding a new Create addon, cutting a decoration mod, swapping one world-gen mod for another. | `x.1.x → x.2.x` when a new mod is added or removed |
| **CONFIG** | Configuration changes only — no mods added or removed, just tuning the values. Tweaking durability, adjusting recipe costs, changing progression gates. | `x.x.0 → x.x.1` Changing how high jetpacks can fly |

A `CONTENT` bump resets `CONFIG` to `0`. A `MAJOR` bump resets both.
