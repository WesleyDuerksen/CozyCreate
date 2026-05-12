# Client Mod Audit — CozyCreate

Per-mod review of `side` classification across all 229 mods, with the goal of removing waste from the client install without breaking the SP-as-build-mode workflow.

## Context

This pack supports **both singleplayer and multiplayer**. Singleplayer is the build-prototype mode: players construct designs in SP, schematize them, and reproduce in MP with the schematic cannon. That constrains side decisions in three important ways:

1. **Block-registry parity is mandatory.** Any mod that registers blocks/items must be `both`, or schematics from SP won't load in MP.
2. **Worldgen exploration is optional in SP.** If a player only uses SP for creative/flat building, worldgen content (custom structures, biomes) isn't strictly required client-side — *provided that mod doesn't add new blocks/items*.
3. **Server-only gameplay tweaks won't apply in SP.** Anything marked `side = "server"` will be missing from the SP integrated server. This is the existing pattern for `crops-love-rain`, `rightclickharvest`, `double-doors`, `netherportalfix`, `noisium` — flagged below for re-review.

## Packwiz side semantics (refresher)

- `side = "both"` — ships in client and server exports
- `side = "client"` — ships only in client export (absent on dedicated server)
- `side = "server"` — ships only in server export (absent in SP and on player's client)

## Methodology

Each `both` mod was evaluated against three questions:

1. **Does it register blocks/items?** If yes → must stay `both` for schematic parity.
2. **Does it have client rendering code?** If yes → must stay `both` (or be `client`).
3. **Is it purely server-side gameplay/worldgen with no SP build relevance?** If yes → candidate for `server`.

For borderline cases I unzipped the JAR and inspected `.class` files, asset paths (`items/`, `blockstates/`, `models/block/`), and data namespaces.

## Verdict summary

| Category | Count | Action |
|---|---|---|
| Confirmed misclassified — definite changes | 4 | Apply |
| Server-only candidates (pure-data worldgen) | ~8 | Apply if SP build mode never needs exploration worldgen |
| Server-only candidates (worldgen mixins, no items) | ~7 | Apply with same caveat — verify no SP exploration intent |
| Existing `server` mods to re-evaluate | 5 | Decide: SP parity or MP-only? |
| Correct as-is | ~205 | Leave |

---

## 1. Confirmed misclassified (apply unconditionally)

| Mod | Current | → | Reason |
|---|---|---|---|
| **chunky** | both | **server** | Pure dedicated-server pre-generation tool. Has only 2 GUI classes (config), no SP relevance — pre-gen in SP is pointless because the player generates as they explore. Verified: 0 assets, 0 data, mostly config/platform classes. |
| **fix-gpu-memory-leak** | both | **client** | GPU memory is a client-only concept. Server has no GL context. Verified: 4 class files, 1 asset, all targeting client GL. |
| **just-enough-professions-jep** | both | **client** | JEI plugin that adds villager workstation lookup to the recipe viewer. Verified: 0 data files, no server registries. Pure client JEI extension. |
| **xaeros-minimap** | both | **client** | Client renderer. Verified: 686 classes incl. 28 client-rendering classes, no server-required content. Server-side waypoint sync exists as a separate companion mod ("Xaero's Map Server Sync") not present in this pack. |
| **xaeros-world-map** | both | **client** | Same reasoning as minimap. Pure client map UI. |

> **Combined client savings:** ~30 MB of JARs and registry/scan overhead removed from the dedicated server export; ~6 MB removed from client install (chunky alone).

---

## 2. Server-only candidates — pure datapack mods (0 class files)

These mods contain only structure NBT, biome JSONs, or loot table data. They place **vanilla blocks**, so removing from the client does not affect schematic block registries. Safe to move to `server` if you accept that SP worlds won't have these structures/biome tweaks.

| Mod | Current | → | Verification |
|---|---|---|---|
| **dungeons-and-taverns** | both | **server** | 0 class files, 4593 data entries, 47 assets (lang only). Pure structure datapack by stardust labs. |
| **incendium** | both | **server** | 0 class files, 4251 data entries, 0 assets. Pure nether datapack. |
| **geophilic** | both | **server** | 0 class files, 1080 data entries, 0 assets. Biome overlay datapack. |

**Decision required:** Do you want SP builders to encounter these structures/biomes? If they only ever build in flat/creative SP worlds, move to server. If they sometimes load a normal SP world for inspiration/reference, keep as both.

---

## 3. Server-only candidates — worldgen mixins, no item registry

These mods have code (mixins, worldgen logic) but verified **zero blocks/items registered**. They modify vanilla worldgen and place vanilla blocks. Safe for schematic parity. Same SP-exploration tradeoff as above.

| Mod | Current | → | Verification (assets / data / classes / item dirs / block dirs) |
|---|---|---|---|
| **yungs-better-end-island** | both | **server** | 5 / 51 / 45 / 0 / 0 — mixins to EndDragonFight; lang only |
| **yungs-better-dungeons** | both | **server** | 10 / 377 / 64 / 0 / 0 — lang only |
| **yungs-better-mineshafts** | both | **server** | 6 / 48 / 51 / 0 / 0 — lang only |
| **yungs-better-strongholds** | both | **server** | 6 / 169 / 32 / 0 / 0 — lang only |
| **yungs-better-nether-fortresses** | both | **server** | 6 / 244 / 26 / 0 / 0 — lang only |
| **yungs-bridges** | both | **server** | 0 / 66 / 31 / 0 / 0 — pure structure+code |
| **yungs-extras** | both | **server** | 0 / 244 / 29 / 0 / 0 — pure structure+code |
| **towns-and-towers** | both | **server** | 0 / 1615 / **3** / 0 / 0 — only 3 thin code classes, mostly data |
| **loot-integrations** | both | **server** | 1 / 58 / 9 / 0 / 0 — loot table merging only |

⚠️ **YungsApi caveat:** `yungs-api` is the shared library these depend on. It also has 0 items/blocks but provides config UI. Worth keeping `both` to be safe, or moving to `server` along with the rest of the YUNG family (verify mod loader doesn't complain about missing-on-client API).

**Recommendation:** Move all YUNG's content mods to server in one batch. Keep `yungs-api` as `both` for one release cycle, then flip if no issues surface.

---

## 4. Mods that look server-only but must stay `both`

These have code mods that register actual items/blocks. Moving to `server` would break SP block registry parity → schematics from MP would fail to load in SP.

| Mod | Current | Verdict | Why must stay both |
|---|---|---|---|
| **tectonic** | both | **keep both** | 57 class files, 369 data entries — terrain code. Even though no items registered, the mixins modify terrain density math and must run on integrated server. |
| **structure-essentials** | both | **keep both** | 26 class files, no data — code library, depended on by other YUNG's mods at runtime. Keep with them. |
| **integrated-villages** | both | **keep both** | 14 class files, has assets and data including `data/create/tags/` — interacts with Create's tag registry; mixed-side classification needed. |
| **repurposed-structures-forge** | both | **keep both** | Known to register some custom blocks (villager workstations etc.). |
| **valhelsia-structures** | both | **keep both** | Adds furniture-style blocks with tile entities. |
| **regions-unexplored** | both | **keep both** | Custom biome blocks (flowers, woods, etc.). |
| **oh-the-biomes-weve-gone** | both | **keep both** | Heavy block/item registry. |
| **oh-the-trees-youll-grow** | both | **keep both** | Custom tree blocks. |

---

## 5. Existing `side = "server"` mods — re-evaluate for SP parity

These five are currently server-only. Given the SP build workflow, decide per-mod whether they should be `both` so SP players get the same gameplay.

| Mod | Current | Question |
|---|---|---|
| **chunky** | server | ✓ Correct — pre-gen makes no sense in SP. Leave. |
| **noisium** | server | Worldgen optimization. SP integrated server would benefit. Consider `both` unless you specifically want SP worldgen to behave differently. |
| **crops-love-rain** | server | Crop growth rate tweak. If a SP builder grows decorative crops, they'd notice the difference. Consider `both`. |
| **rightclickharvest** | server | QoL — right-click to harvest mature crops. Highly desirable in SP too. Strong candidate for `both`. |
| **double-doors** | server | Open one door, both open. QoL. Strong candidate for `both` unless intentionally MP-only. |
| **netherportalfix** | server | Per-player portal linking. Less relevant in SP (only one player), but harmless as `both`. Optional. |

**Recommendation:** Move `rightclickharvest` and `double-doors` to `both` for SP parity. `noisium` to `both` for SP perf. Leave `chunky`. `crops-love-rain` and `netherportalfix` are judgment calls.

---

## 6. Per-mod ledger — full inventory

All 229 mods with current side and verdict. ✓ = correct as classified.

### Performance & memory

| Mod | Side | Verdict | Notes |
|---|---|---|---|
| alltheleaks | both | ✓ | Memory leak fixes touch both sides (entities, GUIs). |
| createbetterfps | client | ✓ | Create-specific rendering optimizations. |
| entityculling | client | ✓ | Skips rendering off-screen entities. |
| ferrite-core | both | ✓ | Deduplicates block state data — both sides benefit from RAM reduction. |
| fix-gpu-memory-leak | both | **→ client** | GPU is client-only. See §1. |
| immediatelyfast | client | ✓ | Vanilla render-loop optimization. |
| leaky | both | ✓ | Forge level/entity leak fixer — useful on integrated server (SP) too. |
| lithium | both | ✓ | Server tick optimizer; needed on integrated server for SP perf. |
| modernfix | both | ✓ | Mixed client/server optimizations. |
| neruina | both | ✓ | Ticking entity crash protection — needed in SP. |
| noisium | server | ⚠ Reconsider | Worldgen perf. Move to `both` so SP gets it too. See §5. |
| reeses-sodium-options | client | ✓ | Sodium config GUI. |
| smooth-chunk-save | both | ✓ | Async chunk save — helps integrated server. |
| sodium | client | ✓ | Rendering engine. |
| sodium-dynamic-lights | client | ✓ | Client light rendering. |
| sodium-options-api | client | ✓ | Sodium config API. |
| spark | both | ✓ | Profiler — both sides. |

### Rendering / visual

| Mod | Side | Verdict | Notes |
|---|---|---|---|
| 3dskinlayers | client | ✓ | 3D skin rendering. |
| ambientsounds | client | ✓ | Ambient audio. |
| athena-ctm | client | ✓ | Connected-textures library. |
| bad-wither-no-cookie | client | ✓ | Silences global wither/elder sounds for distant events. |
| chat-heads | client | ✓ | Player heads in chat. |
| continuity | client | ✓ | Connected textures. |
| distanthorizons | both | ✓ | Has server-side LOD sharing component. |
| euphoria-patches | client | ✓ | Shader patches. |
| iris | client | ✓ | Shader loader. |
| mcqoy | client | ✓ | Client tweak mod. |
| not-enough-animations | client | ✓ | Animation tweaks. |
| particle-rain | client | ✓ | Rain particle FX. |
| sodium-dynamic-lights | client | ✓ | (also in perf above) |
| sound-physics-remastered | both | ⚠ Consider client | 90 classes, no data, 1 renderer. Audio processing is client-only. Could move to `client`. Low priority. |
| subtle-effects | both | ✓ | 351 assets, 43 data — has data registry; some particles need server packets. Keep both. |
| tiny-item-animations | client | ✓ | Item animation tweaks. |
| travelers-titles | client | ✓ | Biome name titles. |

### UI / HUD / QoL

| Mod | Side | Verdict | Notes |
|---|---|---|---|
| antique-atlas-4 | client | ✓ | Map UI. |
| appleskin | both | ✓ | Hunger HUD — server sends saturation packet. |
| armor-statues | both | ✓ | Armor stand GUI + server packets. |
| camerapture | both | ✓ | Camera items. |
| easy-anvils | both | ✓ | Anvil mechanics. |
| easy-magic | both | ✓ | Enchanting mechanics. |
| enchantment-descriptions | client | ✓ | Tooltip mod. |
| explorers-compass | both | ✓ | Server commands + client UI. |
| jade | both | ✓ | Tooltip HUD with server data. |
| jei | both | ✓ | Recipe viewer with server sync. |
| justenoughbreeding | client | ✓ | JEI breeding plugin. |
| just-enough-professions-jep | both | **→ client** | See §1. |
| just-enough-resources-jer | client | ✓ | JEI data plugin. |
| measurements | both | ✓ | Tape measure item. |
| natures-compass | both | ✓ | Biome locator. |
| no-chat-reports | both | ✓ | Chat reporting removal. |
| patchouli | both | ✓ | Guidebook items. |
| pick-up-notifier | both | ✓ | Pickup HUD + server hooks. |
| polymorph | both | ✓ | Recipe conflict UI + server crafting. |
| simple-voice-chat | both | ✓ | Voice chat. |
| surveyor | client | ✓ | Exploration map data. |
| trading-post | both | ✓ | Trading block. |
| trash-cans | both | ✓ | Trash can blocks. |
| trashslot | both | ✓ | Trash slot UI + server validation. |
| visual-workbench | both | ✓ | Workbench block entity. |
| what-are-they-up-to | both | ✓ | Player activity HUD + server data. |
| xaeros-minimap | both | **→ client** | See §1. |
| xaeros-world-map | both | **→ client** | See §1. |

### FTB & Curios stack

| Mod | Side | Verdict |
|---|---|---|
| accessories | both | ✓ Accessory slots with server validation. |
| caelus | both | ✓ Elytra mechanics — both. |
| carry-on | both | ✓ Carrying mechanics. |
| corpse | both | ✓ Death corpse with server logic. |
| curios | both | ✓ Curio slots. |
| elytra-slot | both | ✓ Slot logic. |
| ftb-filter-system | both | ✓ |
| ftb-library-forge | both | ✓ |
| ftb-quests-forge | both | ✓ |
| ftb-teams-forge | both | ✓ |
| ftb-xmod-compat | both | ✓ |
| lootr | both | ✓ Per-player loot — server tracking + client GUI. |
| simple-hats | both | ✓ Hat items. |
| sophisticated-backpacks | both | ✓ |
| sophisticated-core | both | ✓ |
| toms-storage | both | ✓ Storage blocks. |

### Create family (38 mods — all stay `both`)

All Create-family mods register blocks, items, contraptions, and have rendering code. Every one must be `both` for both gameplay function and schematic block parity. Listed for completeness:

`create, create-aeronautics, create-aquatic-ambitions, create-blaze-burner-fuels, create-central-kitchen, create-connected, create-deco, create-deep-dark, create-design-n-decor, create-diesel-generators, create-dragons-plus, create-dreams-and-desires, create-encased, create-enchantment-industry, create-factory, create-fantasizing-again, create-fast-schematic-cannon, create-food, create-framed, create-garnished, create-integrated-farming, create-mechanical-botany, create-metalwork, create-misc-and-things, create-pattern-schematics, create-prismatic-shine, create-railways-navigator, create-sound-of-steam, create-steam-n-rails, create-stuff-additions, create-train-parts, create-transmission, create-vibrant-vaults, create-winery, blocks-bogies, copycats, escalated, gears-n-kinetics, power-grid` — all ✓ both.

### Libraries (correct as both — they ship hooks both sides)

`architectury-api, balm, biolith, blueprint, bookshelf-lib, collective, configurable, corgilib, coroutil, crafttweaker, creativecore, cristel-lib, cupboard, dragonlib, fzzy-config, geckolib, glitchcore, integrated-api, jamlib, kotlin-for-forge, kubejs, lithostitched, moonlight, owo-lib, puzzles-lib, resourceful-lib, rhino, supermartijn642s-config-lib, supermartijn642s-core-lib, terrablender, txnilib, valhelsia-core, yacl, zeta` — all ✓ both.

| Mod | Side | Verdict | Notes |
|---|---|---|---|
| forgified-fabric-api | client | ✓ | Pairs with `connector` (client-only). No Fabric mods on the server. |
| connector | client | ✓ | Sinytra Connector for Fabric→NeoForge — client only since no Fabric mods on server. |

### Worldgen content

| Mod | Side | Verdict | Notes |
|---|---|---|---|
| autumnity | both | ✓ | Custom blocks (mushrooms, snail, etc.). |
| biolith | both | ✓ | (library — also above) |
| dungeons-and-taverns | both | **→ server** | Pure datapack. See §2. |
| ecologics | both | ✓ | Custom blocks/mobs. |
| environmental | both | ✓ | Custom blocks/mobs. |
| friends-and-foes-forge | both | ✓ | Custom mobs. |
| geophilic | both | **→ server** | Pure data biome overlay. See §2. |
| incendium | both | **→ server** | Pure data nether overhaul. See §2. |
| integrated-villages | both | ✓ | Has Create tag interop. Keep both. |
| lets-do-beachparty | both | ✓ | Blocks/items. |
| lets-do-herbalbrews | both | ✓ | Brewing items. |
| lets-do-meadow | both | ✓ | Blocks/mobs. |
| lets-do-vinery | both | ✓ | Wine items. |
| lets-do-wildernature | both | ✓ | Mobs/blocks. |
| lithostitched | both | ✓ | Library — biome injection. |
| loot-integrations | both | **→ server** | Pure data loot merge. See §3. |
| moonlight | both | ✓ | Library + runtime block features. |
| natures-spirit | both | ✓ | Custom biomes/blocks. |
| oh-the-biomes-weve-gone | both | ✓ | |
| oh-the-trees-youll-grow | both | ✓ | |
| realistic-bees | both | ✓ | Behavior tweak. |
| regions-unexplored | both | ✓ | |
| repurposed-structures-forge | both | ✓ | |
| serene-seasons | both | ✓ | Season mechanics + visuals. |
| serene-shrubbery | both | ✓ | Plant blocks. |
| structure-essentials-forge-fabric | both | ✓ | Code library for YUNG's. |
| tectonic | both | ✓ | Code-driven terrain. |
| terrablender | both | ✓ | Biome lib. |
| tidal-towns | both | ✓ | (assume custom items — verify if pursuing) |
| towns-and-towers | both | **→ server** | Only 3 thin classes; mostly data. See §3. |
| upgrade-aquatic | both | ✓ | Aquatic blocks/mobs. |
| valhelsia-structures | both | ✓ | Custom furniture. |
| yungs-api | both | ✓ (or → server with rest) | Library — see §3 caveat. |
| yungs-better-dungeons | both | **→ server** | See §3. |
| yungs-better-end-island | both | **→ server** | See §3. |
| yungs-better-mineshafts | both | **→ server** | See §3. |
| yungs-better-nether-fortresses | both | **→ server** | See §3. |
| yungs-better-strongholds | both | **→ server** | See §3. |
| yungs-bridges | both | **→ server** | See §3. |
| yungs-extras | both | **→ server** | See §3. |

### Cozy / decoration (block-registering — all must be both)

`amendments, beautify, bellsandwhistles, boatload, chefs-delight, chipped, comforts, crate-delight, dark-paintings, decorative-lamps, diagonal-walls, diagonal-windows, dusty-decorations, ends-delight, farmers-delight, flower-tweaks, gallery, handcrafted, idas, immersive-furniture, industrialized-architecture, macaws-holidays, macaws-paintings, macaws-paths-and-pavings, mo-glass, oceans-delight, personality, prickle, quark, sable, slice-and-dice, some-assembly-required, sooty-chimneys, supplementaries, supplementaries-squared, universal-bone-meal` — all ✓ both (register blocks/items, schematic parity required).

### Existing `side = "server"` (re-review)

| Mod | Side | Verdict | Notes |
|---|---|---|---|
| chunky | server | ✓ Correct (currently set this way after section §1 change is applied) | See §5. |
| crops-love-rain | server | ⚠ Optional flip to both | Affects SP crop growth. |
| double-doors | server | ⚠ Recommended → both | QoL desirable in SP. |
| netherportalfix | server | ⚠ Optional flip to both | Less impactful in SP but harmless. |
| noisium | server | ⚠ Recommended → both | Worldgen perf helps SP integrated server. |
| rightclickharvest | server | ⚠ Recommended → both | QoL highly desirable in SP. |

---

## 7. Decisions and action plan

**Confirmed scope:** SP is strictly build-only on superflat worlds. No exploration, no generated terrain features needed client-side. This unlocks Phase C in full.

### Phase A — apply (§1)
Definite fixes, no risk.

| Mod | From | To |
|---|---|---|
| `chunky` | both | server |
| `fix-gpu-memory-leak` | both | client |
| `just-enough-professions-jep` | both | client |
| `xaeros-minimap` | both | client |
| `xaeros-world-map` | both | client |

### Phase B — DO NOT CHANGE
The existing `side = "server"` mods stay server-only. SP is build-only on superflat, so these gameplay tweaks are not needed in SP.

Leave as-is: `crops-love-rain`, `double-doors`, `netherportalfix`, `noisium`, `rightclickharvest`.

### Phase C — apply (§2, §3)
Same rationale as Phase B — SP is build-only, so worldgen content has no SP audience.

| Mod | From | To |
|---|---|---|
| `dungeons-and-taverns` | both | server |
| `incendium` | both | server |
| `geophilic` | both | server |
| `yungs-better-dungeons` | both | server |
| `yungs-better-end-island` | both | server |
| `yungs-better-mineshafts` | both | server |
| `yungs-better-nether-fortresses` | both | server |
| `yungs-better-strongholds` | both | server |
| `yungs-bridges` | both | server |
| `yungs-extras` | both | server |
| `towns-and-towers` | both | server |
| `loot-integrations` | both | server |

`yungs-api` stays `both` for one release as a safety net; flip to `server` later if no issues.

### Phase D — not applied
`sound-physics-remastered` stays `both` (low-impact, deferred).

### Total impact
- **17 mods** flipped (5 in A + 12 in C)
- Client install loses ~12 server-only worldgen JARs and chunky
- Server install loses 4 client-only JARs (gpumemleakfix, JEP, both Xaero's)

### Execution notes for the applying tool
1. Each change is a single-line edit in `mods/<modname>.pw.toml`: `side = "both"` → `side = "server"` (or `client`).
2. After all edits: run `packwiz refresh` to recompute hashes in `index.toml`.
3. Re-export the mrpack via `export.sh`.
4. Validate via `validate.sh` if it tests side-classification.

---

## 8. Confidence notes

- **High confidence:** §1, §2, and §3 verdicts are JAR-inspection-verified (asset/data/class counts, item/block directory checks).
- **Lower confidence:** A handful of "keep both" verdicts in §4 are based on mod-author knowledge rather than per-JAR verification. If a future audit wants to reclaim more, the path is: extract each remaining `both` worldgen mod, grep for `Items.register`/`Blocks.register` patterns, and flip to server if absent.
