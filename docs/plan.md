# CozyCreate — Build Plan

## Stack

- Minecraft 1.21.1 / NeoForge 21.1.228
- Tooling: packwiz (git-tracked) → export as Modrinth mrpack

---

## Validation Approach

Every phase gate has two checks — server (automated) and client (manual checklist).
Both must pass before moving to the next phase.

### Server Test — Automated

```bash
./validate.sh
```

What it does on first run: downloads NeoForge server, installs it, accepts EULA, downloads packwiz-installer-bootstrap.
Every run: serves the pack locally via `packwiz serve`, syncs mods to `server/data/mods/`, starts the server, waits for the `Done (` ready signal, checks logs for ERROR/FATAL, stops the server, reports pass/fail.

The `server/data/` directory holds the runtime — git-tracks authored content (config/, kubejs/, patchouli_books/) but ignores generated state (world/, mods/, logs/).

**Pass criteria:** server reaches ready state + zero errors/fatals in `server/data/logs/latest.log`.
**Acceptable warnings:** see `KNOWN_OK_PATTERNS` array in `validate.sh` — add false positives there as you find them.

### Client Test — Manual Checklist (Prism Launcher)

**One-time Prism bootstrap setup:**

1. Create a new NeoForge 1.21.1 instance in Prism Launcher (name it `CozyCreate-dev`)
2. In instance settings → **Custom commands** → Pre-launch command:
   ```
   "$INST_JAVA" -jar packwiz-installer-bootstrap.jar https://raw.githubusercontent.com/<your-repo>/main/pack.toml
   ```
   _(Until the repo is on GitHub, use the simple export method below)_
3. Drop `packwiz-installer-bootstrap.jar` into the instance's `.minecraft/` folder

**Simple export method (no GitHub needed yet):**

```bash
packwiz modrinth export
# Import the .mrpack into Prism → Add Instance → Import (replaces the instance each time)
```

**Client checklist (run after every phase gate):**

- [ ] Title screen loads without crash
- [ ] Create singleplayer world → world loads in, no crash
- [ ] Join the local test server (`localhost`) → no crash, no missing texture spam
- [ ] Open inventory — all modded items/tabs appear correctly

---

## Testing Workflow

---

## Installation Phases

### Phase 1 — Create Core ✅

The spine of the pack. Install and verify boots clean before adding anything else.

| Mod                       | Slug                          | Version       | Notes                                                                                            |
| ------------------------- | ----------------------------- | ------------- | ------------------------------------------------------------------------------------------------ |
| Create                    | `create`                      | 6.0.10        | Core engine                                                                                      |
| Create: Aeronautics       | `create-aeronautics`          | 1.2.1 bundled | Auto-added: Sable                                                                                |
| Create: Diesel Generators | `create-diesel-generators`    | 1.3.11        |                                                                                                  |
| Create: Power Grid        | `power-grid`                  | 0.5.5.1       | Auto-added: Architectury API                                                                     |
| Steam 'n' Rails NeoForge  | `create-steam-n-rails-1.21.1` | 0.1.0         | Unofficial 1.21.1 fork — pinned to 0.1.0 (0.2.0-beta.2 crashes server with conductor entity bug) |

**Phase 1 gate — must pass before Phase 2:**

- [x] `./validate.sh` → PASSED
- [x] Client: title screen loads
- [x] Client: create world → loads in
- [x] Client: place a Mechanical Press, connect a shaft, run it — no crash
- [x] Client: place a Diesel Generator, fuel it — no crash
- [x] Client: connect to local test server → no crash

---

### Phase 2 — Create Addons ✅

Install in batches. Run `./validate.sh` after each batch — don't stack batches on a failing server.

**Batch A — Core Create QoL & Decoration**

- `create-connected` — connected textures for casings/shafts
- `copycats` — dress Create blocks in any texture
- `bellsandwhistles` — decorative blocks for stations/engineering spaces
- `create-dreams-and-desires` — QoL + visual polish
- `create-deco` — industrial decoration

**Batch B — Engineering Depth**

- `create-enchantment-industry` — automates enchanting
- `slice-and-dice` — Farmer's Delight × Create integration
- `create-garnished` — nut trees + food for automation

**Batch C — Trains & Rail**

- `create-railways-navigator` — train schedule/route HUD (replaces Track Map)
- `create-blocks-and-bogies` ⚠️ — extended bogie types (slug unverified on Modrinth)
- `create-train-parts` ⚠️ — additional train car types (slug unverified)

**Batch D — Extended Create Ecosystem**
Verified 2026-05-08: all 17 are on Modrinth but none have 1.21.1 NeoForge releases yet. Skip for now; revisit when ported.

| Mod                            | Modrinth Slug (corrected)      | Status                       |
| ------------------------------ | ------------------------------ | ---------------------------- |
| Create: Bits 'n' Bobs          | `create-bits-n-bobs`           | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Blaze Burner Fuels     | `create-blaze-burner-fuels`    | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Escalated              | `escalated`                    | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Factory                | `create-factory`               | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Fast SchematicCannon   | `create-fast-schematic-cannon` | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Framed                 | `create-framed`                | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Gears n' Kinetics      | `gears-n-kinetics`             | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Mechanical Botany      | `create-mechanical-botany`     | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Metalwork              | `create-metalwork`             | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Pattern Schematics     | `create-pattern-schematics`    | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Rubberworks            | `create-rubberworks`           | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Some Assembly Required | `some-assembly-required`       | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Stuff 'n' Additions    | `create-stuff-additions`       | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Transmission!          | `create-transmission`          | ⏭️ skip — no 1.21.1 NeoForge |
| Create Encased                 | `create-encased`               | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Misc & Things          | `create-misc-and-things`       | ⏭️ skip — no 1.21.1 NeoForge |
| Create: Copper Splashing       | `copper-splashing`             | ❌ CurseForge-only           |

**Batch E — Create Food & Drink**
Verified 2026-05-08: all 5 confirmed on Modrinth with 1.21.1 NeoForge. (Dragons Plus already installed as dependency of Enchantment Industry.)

| Mod                        | Slug                        | Status      |
| -------------------------- | --------------------------- | ----------- |
| Create: Aquatic Ambitions  | `create-aquatic-ambitions`  | ✅ verified |
| Create: Central Kitchen    | `create-central-kitchen`    | ✅ verified |
| Create: Food               | `create-food`               | ✅ verified |
| Create: Integrated Farming | `create-integrated-farming` | ✅ verified |
| Create: Winery             | `create-winery`             | ✅ verified |

**Batch F — Create Decoration & Aesthetics**
Verified 2026-05-08: 6 install, 2 skip.

| Mod                                 | Slug                       | Status                       |
| ----------------------------------- | -------------------------- | ---------------------------- |
| Create: Deep Dark                   | `create-deep-dark`         | ✅ verified                  |
| Create: Design n' Decor             | `create-design-n-decor`    | ✅ verified (slug corrected) |
| Create: Fantasizing Again           | `create-fantasizing-again` | ✅ verified (slug corrected) |
| Create: Industrialized Architecture | —                          | ❌ not on Modrinth           |
| Create: Prismatic Shine             | `create-prismatic-shine`   | ✅ verified                  |
| Create: Sound of Steam              | `create-sound-of-steam`    | ✅ verified                  |
| Create: Vibrant Vaults              | `create-vibrant-vaults`    | ✅ verified                  |
| Create Better FPS                   | `createbetterfps`          | ⏭️ skip — no 1.21.1 NeoForge |

**Phase 2 gate — must pass before Phase 3:**

- [x] `./validate.sh` → PASSED (32 jars, Batches A-C + E-F; Batch D skipped — no 1.21.1 NeoForge)
- [x] Client: title screen + world load — no crash
- [x] Client: connected textures visible on Create casings (Batch A)
- [x] Client: connect to local test server → no crash

---

### Phase 3 — Decoration & Ambience ✅

Drawn from the Homestead shortlist. Full list in `research/homestead-phase4-shortlist.md`.

**Batch A — Core Ambience**

- `ambientsounds` + `creativecore` dep
- `sound-physics-remastered`
- `particle-rain`
- `sodium-dynamic-lights` + `sodium`, `sodium-options-api`, `reeses-sodium-options` deps

**Batch B — Core Decoration**

- `supplementaries` + `moonlight` dep
- `supplementaries-squared`
- `handcrafted` + `resourceful-lib` dep
- `chipped` + `athena-ctm` dep
- `farmers-delight`

**Batch C — Let's Do Series**

- `lets-do-vinery`
- `lets-do-herbalbrews`

**Batch D — Decoration & Furniture (19 mods)**

- `amendments`, `beautify`, `camerapture`
- `dark-paintings` + `prickle`, `bookshelf` deps
- `decorative-lamps` + `sinytra-connector`, `forgified-fabric-api` deps _(Fabric mod via Connector; server-side jar skipped safely)_
- `diagonal-walls`, `diagonal-windows` + `puzzles-lib` dep
- `double-doors` + `collective` dep
- `dusty-decorations` + `geckolib` dep _(geckolib dep was not auto-detected; added manually)_
- `immersive-furniture`
- `macaws-paintings`, `macaws-paths-and-pavings`, `macaws-holidays`
- `mo-glass`, `serene-shrubbery`
- `simple-hats` + `accessories`, `owo-lib` deps
- `sooty-chimneys`, `armor-statues`
- `antique-atlas-4` + `surveyor`, `mcqoy` deps + `yacl` dep _(mcqoy client-only; yacl not auto-detected, added manually)_

**Batch E — Visual Polish**

- `iris` (replaces `oculus` — oculus only goes to 1.20.1)
- `not-enough-animations`
- `subtle-effects` + `fzzy-config` dep
- `tiny-item-animations`
- `euphoria-patches`
- `continuity` (confirmed NeoForge 1.21.1 support)
- _(embeddium skipped — official Sodium was already auto-installed as dep of sodium-dynamic-lights)_

**Installer fix applied:** Added `--side server` flag to packwiz-installer-bootstrap call in `validate.sh`. Without this, the installer cached "client" side and deployed client-only mods to the server.

**New KNOWN_OK_PATTERNS added:**

- `Fabric API detected.*Moonlight` — Moonlight Lib cosmetic error when Sinytra Connector is present
- `Couldn't parse element.*beautify:blocks/` — Beautify 2.0.2 malformed loot table format (same as Create Deco/Food)
- `Parsing error loading recipe create:crafting/kinetics/` — Create 6.0.10 gearbox recipe format mismatch
- `Parsing error loading recipe dndesires:crafting/` — Dreams & Desires omni_gearbox recipe format mismatch
- `is a Fabric mod and cannot be loaded` — Decorative Lamps jar skipped on server; loads via Connector on client

**Phase 3 gate — must pass before Phase 4:**

- [x] `./validate.sh` → PASSED (79 server jars; client-only mods correctly excluded)
- [x] Client: title screen + world load — no crash
- [x] Client: connect to local test server → no crash

---

### Phase 4 — Adventure & World ✅

Exploration, structures, mobs. Full list in research files.

**Batch A — World Gen Libraries**

- `terrablender`, `lithostitched` — biome/worldgen compat libs
- `yungs-api` — YUNG's structure lib
- `serene-seasons` + `glitchcore` dep — seasons system
- `biolith` — required by Regions Unexplored (NeoForge port exists)

**Batch B — Biomes**

- `tectonic`, `natures-spirit`, `geophilic`, `regions-unexplored` — overworld terrain
- `oh-the-biomes-weve-gone` + `corgilib`, `oh-the-trees-youll-grow` deps
- `incendium` — nether biomes
- `autumnity` + `blueprint` dep, `environmental`, `ecologics` — seasonal/evocative biomes
- _(eldritch-end skipped — no 1.21.1 release)_

**Batch C — Structures**

- YUNG's suite: `yungs-better-dungeons`, `yungs-better-mineshafts`, `yungs-better-nether-fortresses`, `yungs-better-strongholds`, `yungs-better-end-island`, `yungs-bridges`, `yungs-extras`
- `towns-and-towers` + `cristel-lib` dep, `dungeons-and-taverns`
- `repurposed-structures` (NeoForge variant)
- `valhelsia-structures` + `valhelsia-core` dep
- `idas` + `quark`, `zeta`, `integrated-api` deps (Quark pulled in as IDAS dep)
- `integrated-villages`
- `structure-essentials` (CurseForge) + `cupboard` dep, `loot-integrations` (CurseForge)

**Batch D — Mobs, Navigation & World QoL**

- `friends-and-foes-forge`, `upgrade-aquatic` — new creatures
- `lootr` — per-player loot chests
- `explorers-compass`, `natures-compass` — find structures/biomes
- `travellers-titles` — biome/dimension title cards
- `gallery`, `boatload` — vanilla+ art display and boat types
- _(alex's-mobs skipped — no 1.21.1 release)_
- `personality` — NPC personality/mood variety (found 1.21.1 release on CurseForge; added as `personality-1.21.1-5.0.2.jar`)
- `tidal-towns` — coastal ocean village structures (Modrinth; added as `tidal-towns-1.3.4.jar`)

**New KNOWN_OK_PATTERNS added (Phase 4):**

- `Reference map.*could not be read` — broadened from Veil-specific to cover all dev-env mixin refmap warnings
- `Error loading class:.*ClassNotFoundException` — mixin compat shims for optional mods
- `Error loading class:.*invalid dist DEDICATED_SERVER` — client-only classes scanned by mixin processor
- `Method overwrite conflict` / `Discarding @Unique` — mixin dedup/conflict, benign
- `JarJar.*passed in as source` — externally provided dep jar (architectury)
- `modid:example.*data map.*dimension` — Blueprint 8.1.0 leaves example placeholder in modded_biome_slice_sizes.json
- `idas:chests/` / `idas:has_structure/` — IDAS compat tables for Ice and Fire / Ars Nouveau / BYG/BOP
- `valhelsia_structures:chests/spawner_dungeon_dispenser` — uses removed set_nbt loot function
- `bei_ExtraDragonFight` — YUNG's Better End Island missing world key on fresh worlds
- `garnished:dye_blowing/quark/` — Garnished × Quark compat recipe format mismatch
- `Couldn't load advancements:.*wander_add_map` — vanilla trader advancements fail with structure mods
- `Integrated API Error: Couldn't parse spawner mob list idas:` — IDAS mob lists for uninstalled mods
- `LootrServiceRegistry.*not found` — Quark's Lootr compat mixin, Lootr not installed

**Phase 4 gate — must pass before Phase 5:**

- [x] `./validate.sh` → PASSED (122 server jars)
- [x] Client: title screen + world load — no crash
- [ ] Client: connect to local test server → no crash

---

### Phase 5 — QoL, Performance & Food (not yet started)

Remaining mods from the shortlist: performance optimisers, QoL infrastructure, storage, and the food/farming layer.
Sodium, Iris, Chunky, ModernFix, and FerriteCore were already added in earlier phases.

**Batch A — Performance**

- `entityculling` — skip rendering hidden entities
- `immediately-fast` — immediate mode rendering speed
- `lithium` — game logic optimisations (NeoForge port)
- _(noisium skipped — Fabric-only, no NeoForge port)_
- _(debugify skipped — verify NeoForge availability before adding)_

**Batch B — Core QoL**

- `jade` — block/entity info HUD
- `jei` — recipe viewer
- `no-chat-reports` — chat privacy from Mojang reporting
- `xaeros-minimap` — minimap
- `xaeros-world-map` — full world map

**Batch C — Multiplayer Infrastructure**

- `simple-voice-chat` — proximity voice for collaborative engineering
- `spark` — performance profiling
- `universal-graves` — preserve items on death
- `polymorph` — resolve conflicting recipes
- `curios-api` — NeoForge accessory standard (Curios)
- `elytra-slot` — dedicated elytra slot (depends on Curios)

**Batch D — Storage & Inventory**

- `sophisticated-backpacks` — tiered upgradeable backpacks
- `toms-storage` — network-based centralised storage
- `carry-on` — pick up and carry chests and tile entities
- `trashslot` — inventory delete slot
- _(trash-cans — verify NeoForge slug)_

**Batch E — Food & Farming**

- `comforts` — sleeping bags and hammocks
- `chef's-delight`, `ocean's-delight`, `end's-delight`, `nature's-delight`, `crate-delight` — Farmer's Delight expansions
- `lets-do-beachparty`, `lets-do-meadow`, `lets-do-wildernature` — Let's Do food series
- `duckling` — tameable ducks
- `realistic-bees` — better bee mechanics
- `rightclickharvest` — right-click to harvest crops
- `crops-love-rain` — rain speeds crop growth
- `universal-bone-meal` — bone meal on everything
- `flower-tweaks` — flower breeding and crafting

**Batch F — Progression & Scripting**

- `patchouli` — in-game guidebook for engineering progression
- `kubejs` + `rhino` dep — recipe and event scripting
- `crafttweaker` — recipe customisation
- _(ftb-quests — CurseForge-only, not on Modrinth; skipped)_

**Mods skipped (no NeoForge 1.21.1 release):**

- `duckling` — no NeoForge release
- `debugify` — no NeoForge release
- `universal-graves` / `gravestones` — no NeoForge 1.21.1 (replaced by `corpse`)
- `ftb-quests` — CurseForge-only

**Mods cut (compat crash):**

- `natures-delight` — broken mixin targeting Farmer's Delight `RichSoilBlock`; no refMap, hard crash on load

**New KNOWN_OK_PATTERNS added (Phase 5):**

- `Failed to load plugin.*KubeJSPlugin.*create_aquatic_ambitions` — Aquatic Ambitions optional KubeJS plugin class missing; mod loads fine
- `Tried to load invalid item.*alexsmobs:` — food compat recipes reference Alex's Mobs items not installed; recipes skip gracefully

**Phase 5 gate — must pass before Phase 6:**

- [x] `./validate.sh` → PASSED (162 server jars)
- [x] Client: title screen + world load — no crash
- [x] Client: connect to local test server → no crash
- [x] Client: minimap visible, JEI accessible, voice chat present in settings

---

**0.2.0**
### Mod additions/removals
- [x] ~~Add Valhasia~~ — mod does not exist; was a mistake
- [x] Add `create-new-additional-recipes` — Create recipe expansions (added `additionalrecipes-0.0.3.jar`)
- [x] Add `create-power-loader` — Create-powered andesite/brass chunk loaders (added `create_power_loader-2.0.4-mc1.21.1.jar`)
- [x] Dedup map mods — removed Xaero's Minimap + World Map; Antique Atlas kept as sole map system
- [x] Overlap audit — no other duplicates found; Tidal Towns + Personality documented in Phase 4

### Configurations
- [x] Change garbage collector — ZGC flags added to `instance.cfg` in `export.sh`
- [x] Chunky safe — `continueOnRestart=false` already set; overworld task is `cancelled=true`; no changes needed
- [x] Side classification audit applied — 15 mods reclassified per `client-mod-audit.md` (Phase A + C)
- [x] Default 6GB RAM — `MaxMemAlloc=6144` + `MinMemAlloc=2048` added to `instance.cfg` in `export.sh`

**0.2.1**
- [x] Do an optimization pass for the client to see what we can do to help potato computers (for example, disabling Distant horizons by default on the client)
  - DH renderer shipped as `rendererMode = "DISABLED"` in `DistantHorizons.toml` (jar still installed; user opts in)
  - Client zip now ships `assets/options.txt` baseline via `export.sh`: renderDistance=8, simulationDistance=8, particles=minimal, graphicsMode=fancy, entityShadows=on

**0.2.2**
Dockerized the server and optimized

**0.2.3**
- [x] Gui scale = 3x 
- [x] Music = 10%
- [x] Max framerate 60fps
- [x] minimized DH settings

**0.3.0**
- Removed DH
- Change default ram numbers

**0.3.1**
Memory optimization pass — ModernFix perf/bugfix mixins enabled in `server/data/config/modernfix-mixins.properties`:
- [x] `mixin.perf.dynamic_resources=true` — lazy block model loading (targets BakedQuad ~267 MB, ModelResourceLocation ~95 MB)
- [x] `mixin.perf.dynamic_entity_renderers=true` — lazy entity renderer loading
- [x] `mixin.perf.compact_entity_models=true` — compacted entity model storage
- [x] `mixin.perf.ingredient_item_deduplication=true` — recipe ingredient dedup
- [x] `mixin.perf.deduplicate_climate_parameters=true` — biome climate dedup
- [x] `mixin.perf.deduplicate_location=true` — resource location dedup
- [x] `mixin.perf.faster_item_rendering=true` — model lookup optimization
- [x] `mixin.bugfix.packet_leak=true` — fixes known packet-handler leak
- [x] `mixin.bugfix.skip_redundant_saves=true` — avoids redundant chunk-write allocations

**0.3.2**
More leak hunting configs

**1.0.0**
- [x] We need quests to help the users understand that this is a cozy container around steam/diesel punk create. See postInstall.md for the core mods. You see there will be a lot of veteran Minecraft players who have played the game for over a decade and know it inside out and this'll be their first modpack so have some guidance on what is in this modpack would be good. And perhaps quests is a poor way of explaining this. But at the bare minimum a book they spawn in with that explained what all was in this "Minecraft 2.0" and how to find more information so to speak would go a long way.
- [x] Verified VC functionality with two clients
- [x] Set ram defaults to min 2G max 6G

### Server launch prep

**Set world borders (10K radius = 20,000 diameter, square):**
```
/worldborder center 0 0
/worldborder set 20000
/execute in minecraft:the_nether run worldborder center 0 0
/execute in minecraft:the_nether run worldborder set 20000
/execute in minecraft:the_end run worldborder center 0 0
/execute in minecraft:the_end run worldborder set 20000
```

**Pre-gen with Chunky (already installed):**
```
/chunky world overworld
/chunky center 0 0
/chunky radius 10000
/chunky start

/chunky world the_nether
/chunky center 0 0
/chunky radius 10000
/chunky start

/chunky world the_end
/chunky center 0 0
/chunky radius 10000
/chunky start
```

**1.1.0** 
- [ ] Add https://modrinth.com/mod/create-railways-navigator
- [ ] Add https://modrinth.com/mod/create-track-map
- [ ] Add https://modrinth.com/mod/create-bits-n-bobs
- [ ] Add https://modrinth.com/mod/create-copper-zinc

## Key Decisions Log

- **Transport philosophy:** No teleportation or non-Create travel mods. All transport must be built infrastructure.
- **Power:** Create: Power Grid is the only electricity system. New Age and Crafts & Additions both cut.
- **Rails:** Steam 'n' Rails (unofficial 1.21.1 fork) + Blocks & Bogies + Train Parts. Navigator replaces Track Map.
- **Audio:** Sodium Dynamic Lights replaces LambDynamicLights.
- **Confectionery cluster cut:** Café, Chocolate Fountain, Confectionery, Mechanical Confection all removed.
- **Claims cut:** Aeronautics Claims and Open Parties and Claims both removed (trusted server).
