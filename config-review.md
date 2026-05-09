# Server Config Review

Track which configs have been reviewed and tuned. Work through tiers in order — Tier 1 must be done before the server goes live, Tier 2 before the world is generated.

**Legend:** unchecked = not reviewed · checked = reviewed (defaults accepted or changes made) · ~~strikethrough~~ = mod dropped

---

## Tier 1 — Performance (do before anything else)

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `ferritecore-mixin.toml` | Memory dedup — verify mixins enabled |
| [ ] | `modernfix-common.toml` | Async loading, entity culling — review each section |
| [ ] | `modernfix-mixins.properties` | Mixin toggles for modernfix — leave most default |
| [ ] | `lithium.properties` | Chunk/AI/physics optimizations — verify all on |
| [ ] | `sodium-mixins.properties` | Rendering mixins — server-irrelevant but track |
| [ ] | `smoothchunk.json` | Chunk loading smoothing |
| [ ] | `alltheleaks.json` | Memory leak tracker — configure reporting |
| [ ] | `leaky.json` | Companion to alltheleaks |
| [ ] | `spark/` (dir) | Profiler — no tuning needed, just confirm present |
| [ ] | `neruina.json5` | Crash loop recovery — review tick freeze thresholds |
| [ ] | `connector.json` | Sinytra Connector — Fabric compat layer |
| [ ] | `fml.toml` | NeoForge mod loading — leave default |
| [ ] | `neoforge-common.toml` | NeoForge common settings |
| [ ] | `neoforge-server.toml` | NeoForge server settings |

---

## Tier 1 — Create Core (core gameplay balance)

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `create-common.toml` | Stress limits, kinetic capacity, contraption rules |
| [ ] | `create-server.toml` | Server-side Create settings — check contraption entity limits |
| [ ] | `powergrid-common.toml` | Power Grid network settings |
| [ ] | `powergrid-server.toml` | Power Grid server settings |
| [ ] | `createdieselgenerators-common.toml` | Diesel gen output/fuel values |
| [ ] | `createdieselgenerators-server.toml` | Diesel gen server settings |
| [ ] | `aeronautics-server.toml` | Airship stress, size limits, flight physics |

---

## Tier 2 — World Gen (lock in before generating world)

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `tectonic.json` | Terrain generation — major world shape settings |
| [ ] | `terrablender.toml` | Biome weight distribution |
| [ ] | `lithostitched.json` | World gen stitching |
| [ ] | `biomeswevegone/` (dir) | BWG biome toggles — disable any that don't fit aesthetic |
| [ ] | `natures_spirit-common.toml` | Nature's Spirit biomes |
| [ ] | `ecologics-common.toml` | Ecologics biome content |
| [ ] | `environmental-common.toml` | Environmental biomes |
| [ ] | `autumnity-common.toml` | Autumnity biome settings |
| [ ] | `upgrade_aquatic-common.toml` | Ocean content |
| [ ] | `wildernature-common.toml` | Wild nature mobs/biomes |
| [ ] | `meadow-common.toml` | Meadow content |
| [ ] | `beachparty-common.toml` | Beach content |
| [ ] | `regions_unexplored/` (dir) | Regions Unexplored biome toggles |
| [ ] | `sereneseasons/` (dir) | Season lengths and effects |
| [ ] | `cristellib/` (dir) | Structure library settings |
| [ ] | `betterdungeons-neoforge-1_21.toml` | Dungeon gen frequency/size |
| [ ] | `betterfortresses-neoforge-1_21.toml` | Nether fortress improvements |
| [ ] | `betterfortresses/` (dir) | Fortress structure configs |
| [ ] | `bettermineshafts-neoforge-1_21.toml` | Mineshaft gen |
| [ ] | `betterstrongholds-neoforge-1_21.toml` | Stronghold layout |
| [ ] | `betterstrongholds/` (dir) | Stronghold structure configs |
| [ ] | `betterendisland-neoforge-1_21.toml` | End island improvements |
| [ ] | `idas-neoforge-1_21.toml` | IDAS structure settings |
| [ ] | `integrated_villages-neoforge-1_21.toml` | Village integration |
| [ ] | `repurposed_structures-neoforge/` (dir) | RS structure frequency per biome |
| [ ] | `towns_and_towers/` (dir) | Towns and Towers structure settings |
| [ ] | `vanilla_structures/` (dir) | Vanilla structure tweaks |
| [ ] | `structureessentials.json` | Structure spawn rules |
| [ ] | `lootintegrations.json` | Loot table cross-mod injection |

---

## Tier 2 — Multiplayer Systems

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `ftbteams-server.snbt` | Team size, permissions, party settings |
| [ ] | `ftbxmodcompat.snbt` | FTB cross-mod compat flags |
| [ ] | `railways-common.toml` | Steam 'n' Rails — train speed, stress, network |
| [ ] | `railways-server.toml` | SaR server settings |
| [ ] | `createrailwaysnavigator-common.toml` | Navigator schedule/routing settings |
| [ ] | `voicechat/` (dir) | Simple Voice Chat — codec, range, server port |
| [ ] | `lootr-common.toml` | Per-player loot chests — confirm enabled for MP |
| [ ] | `corpse-server.toml` | Death chest settings, timer, loot protection |
| [ ] | `NoChatReports/` (dir) | Chat report suppression |

---

## Tier 3 — Create Addons

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `create_enchantment_industry-server.toml` | Enchanting costs, liquid XP rates |
| [ ] | `create_connected-common.toml` | Connected textures settings |
| [ ] | `create_connected-server.toml` | Connected textures server side |
| [ ] | `create_deep_dark-common.toml` | Deep dark Create content |
| [ ] | `dragonlib-common.toml` | Dragon lib framework common |
| [ ] | `dragonlib-server.toml` | Dragon lib framework server |
| [ ] | `create_dragons_plus-common.toml` | Dragons Plus content |
| [ ] | `create_dragons_plus-server.toml` | Dragons Plus server |
| [ ] | `create_dragons_plus-simulated-extension-common.toml` | Simulated extension common |
| [ ] | `create_dragons_plus-simulated-extension-server.toml` | Simulated extension server |
| [ ] | `create_aquatic_ambitions-server.toml` | Aquatic Ambitions server |
| [ ] | `create_central_kitchen-common.toml` | Central Kitchen recipes/machines |
| [ ] | `create_integrated_farming-server.toml` | Integrated Farming server |
| [ ] | `create_fantasizing-server.toml` | Fantasizing server |
| [ ] | `create-stuff-additions.toml` | Stuff & Additions machines |
| [ ] | `createfastschematiccannon-common.toml` | Fast cannon — placement rate, range |
| [ ] | `createfood-server.toml` | Create Food server |
| [ ] | `createcasing-common.toml` | Casing compat |
| [ ] | `sliceanddice-common.toml` | Slice & Dice farming compat |
| [ ] | `mechanical_botany-server.toml` | Botanical automation |
| [ ] | `gnkinetics-server.toml` | GN Kinetics server |
| [ ] | `simulated-server.toml` | Simulated server settings |
| [ ] | `offroad-server.toml` | Offroad vehicle settings |
| [ ] | `escalated-server.toml` | Escalated server |
| [ ] | `someassemblyrequired-server.toml` | SAR machine settings |

---

## Tier 3 — Storage & Inventory

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `sophisticatedbackpacks-common.toml` | Backpack tier costs, slot counts |
| [ ] | `sophisticatedbackpacks-server.toml` | Server-side backpack rules |
| [ ] | `sophisticatedcore-common.toml` | Core settings shared by Sophisticated suite |
| [ ] | `toms_storage-common.toml` | Tom's Storage network settings |
| [ ] | `toms_storage-server.toml` | TomS server settings |
| [ ] | `accessories.json5` | Accessories slot config |
| [ ] | `curios-common.toml` | Curios slot definitions |
| [ ] | `curios-server.toml` | Curios server |
| [ ] | `carryon-common.toml` | Carry On entity/block lifting — whitelist heavy blocks |
| [ ] | `trashcans-common.toml` | Trash can settings |
| [ ] | `trashslot-common.toml` | Trash slot settings |

---

## Tier 3 — Progression & Enchanting

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `easymagic-common.toml` | Enchanting table — reroll costs |
| [ ] | `easymagic-server.toml` | Easy Magic server |
| [ ] | `easyanvils-common.toml` | Anvil level cap and repair cost |
| [ ] | `easyanvils-server.toml` | Easy Anvils server |
| [ ] | `quark-common.toml` | Quark feature toggles — disable anything that conflicts |
| [ ] | `zeta-common.toml` | Zeta module framework (Quark core) |
| [ ] | `explorerscompass-common.toml` | Compass item settings |
| [ ] | `naturescompass-common.toml` | Nature's Compass biome finder |
| [ ] | `tradingpost-server.toml` | Trading post NPC settings |

---

## Tier 4 — Food & Farming

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `farmersdelight-common.toml` | FD crop/food settings |
| [ ] | `chefsdelight-common.toml` | Chef's Delight recipes |
| [ ] | `herbalbrews-common.toml` | Herbal brews effects/durations |
| [ ] | `ends_delight-common.toml` | End Delight content |
| [ ] | `cropsloverain.toml` | Rain crop growth boost |
| [ ] | `realisticbees.json5` | Bee behavior settings |
| [ ] | `universalbonemeal-server.toml` | Bonemeal compat |
| [ ] | `vinery.toml` | Vinery wine/grape settings |

---

## Tier 4 — Decoration & Ambience

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `supplementaries-common.toml` | Supplementaries features — disable any conflicts |
| [ ] | `suppsquared-common.toml` | Supplementaries Squared |
| [ ] | `amendments-common.toml` | Amendments block behavior |
| [ ] | `amendments-client.toml` | Amendments client settings |
| [ ] | `beautify-server.toml` | Beautify decorations |
| [ ] | `dndecor-server.toml` | Decocraft-style decorations |
| [ ] | `dndesires-server.toml` | DN Desires content |
| [ ] | `Dusty Decorations Config.toml` | Dusty Decorations settings |
| [ ] | `gallery-common.toml` | Gallery mod settings |
| [ ] | `copycats-common.toml` | Copycats block copying rules |
| [ ] | `copycats-server.toml` | Copycats server |
| [ ] | `sootychimneys-common.toml` | Chimney smoke/particle settings |
| [ ] | `pipeorgans-server.toml` | Pipe Organs server |
| [ ] | `visualworkbench-common.toml` | Visual Workbench table display |
| [ ] | `doubledoors.json5` | Double door sync settings |
| [ ] | `rightclickharvest.json5` | Right-click harvest crop list |
| [ ] | `sable-common.toml` | Sable arts settings |
| [ ] | `personality-common.toml` | NPC personality settings |
| [ ] | `friendsandfoes.json` | Friends & Foes mob settings |
| [ ] | `CoroUtil/` (dir) | CoroUtil framework settings |

---

## Tier 4 — QoL & Misc (likely fine at defaults)

| Done | Config | Notes |
|------|--------|-------|
| [ ] | `comforts-common.toml` | Sleeping bag/hammock settings |
| [ ] | `comforts-server.toml` | Comforts server |
| [ ] | `jade/` (dir) | Jade tooltip config |
| [ ] | `jamlib/` (dir) | JAMlib framework |
| [ ] | `simplehats.json` / `simplehats.json5` | Hat cosmetic settings |
| [ ] | `pickupnotifier/` (dir) | Item pickup notifications |
| [ ] | `xaero/` (dir) | Xaero minimap — death waypoints, sharing |
| [ ] | `surveyor.toml` | Map surveyor settings |
| [ ] | `camerapture.server.json` | Camera mod server settings |
| [ ] | `sound_physics_remastered/` (dir) | Sound physics — reverb, occlusion |
| [ ] | `watut-common.toml` | WATUT settings |
| [ ] | `watut-server.toml` | WATUT server |
| [ ] | `watut-client.toml` | WATUT client |
| [ ] | `watut-item-arm-adjustments.json` | WATUT item arm positions |
| [ ] | `moonlight-common.toml` | Moonlight lib settings |
| [ ] | `blueprint-common.toml` | Blueprint lib settings |
| [ ] | `collective.json5` | Collective lib settings |
| [ ] | `cupboard.json` | Cupboard lib settings |
| [ ] | `creativecore.json` | CreativeCore settings |
| [ ] | `mcqoy.toml` | McQOY settings |
| [ ] | `jei-server.toml` | JEI server-side recipe sync |
| [ ] | `chunky/` (dir) | Chunky pre-gen settings |

---

## Dropped Mods (configs may still exist on disk)

| Config | Reason dropped |
|--------|---------------|
| ~~`despawntweaks-common.toml`~~ | Data component registry conflict — blocks client connection |
| ~~`quark-common-1.toml.bak`~~ | Backup file from Quark update, not a live config |
