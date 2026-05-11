# Server Config Review

Track which configs have been reviewed and tuned. Work through tiers in order — Tier 1 must be done before the server goes live, Tier 2 before the world is generated.

**Legend:** unchecked = not reviewed · checked = reviewed (defaults accepted or changes made) · ~~strikethrough~~ = mod dropped

---

## Tier 1 — Performance (do before anything else)

| Done | Config | Notes |
|------|--------|-------|
| [x] | `ferritecore-mixin.toml` | Defaults — safe optimizations on, risky options (compactFastMap, useSmallThreadingDetector) correctly off |
| [x] | `modernfix-common.toml` | Defaults — only contains JEI plugin blacklist |
| [x] | `modernfix-mixins.properties` | Defaults — file is documentation-only, no overrides needed |
| [x] | `lithium.properties` | Defaults — empty file = all optimizations on |
| [x] | `sodium-mixins.properties` | Defaults — empty, server-irrelevant |
| [x] | `smoothchunk.json` | Defaults — 300s save delay, 20 chunk unloads/tick, protochunks not saved |
| [x] | `alltheleaks.json` | Defaults — 90% mem warning, 10min log interval |
| [x] | `leaky.json` | **Changed:** `chatnotification` PLAYER→OP. Trusted-MP lens: route lag warnings to admins, not random builders |
| [x] | `spark/` (dir) | Defaults — backgroundProfiler enabled |
| [x] | `neruina.json5` | Defaults — handle_ticking_* all true, threshold 10. `auto_kill_ticking_entities=false` keeps errors visible during dev; revisit at launch |
| [x] | `connector.json` | Defaults — mixin safeguard enabled |
| [x] | `fml.toml` | Defaults |
| [x] | `neoforge-common.toml` | Defaults |
| [x] | `neoforge-server.toml` | Defaults — removeErroringBlockEntities/Entities correctly off (don't silently break things) |

---

## Tier 1 — Create Core (core gameplay balance)

Re-analyzed through the design lens (engineering depth vs. creative agency, automation-as-infrastructure, no shortcuts). Defaults align strongly with the pack's philosophy — the most important agency-preserving knobs are already in the right state.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `create-common.toml` | Defaults — `disableWorldGen=false` keeps Create ore/material progression intact |
| [x] | `create-server.toml` | Defaults. **Critical preserved:** `bulkPressing`/`bulkCutting=false` (forces "build more presses" engineering decision); `disableStress=false` (stress is the central puzzle); `fillInfinite=false` + 10k threshold (anti-trivialization); `harvestPartiallyGrown=false`+`harvesterReplants=true` (good farm design); `trainsCauseDamage=true` (authentic infrastructure) |
| [x] | `powergrid-common.toml` | Defaults — `fullStateSynchronizationInterval=100` (every 5s) is right for MP |
| [x] | `powergrid-server.toml` | Defaults. **Critical preserved:** `overheating`/`wireOverheating`/`explosiveDeconstruction` all true (these *are* the electrical engineering challenge). `solverBackend="JAVA"` — switch to NATIVE at launch for perf if host supports it. `splittingTransmissionLines`/`splittingsTransformers=false` (experimental, stability-first) |
| [x] | `createdieselgenerators-common.toml` | Defaults — tank/canister capacities |
| [x] | `createdieselgenerators-server.toml` | Defaults. **Critical preserved:** `Engines filled with a bucket=false` (forces pipe infrastructure — fuel logistics IS engineering); `Engines disabled with redstone=true`; `Combustibles blow up=true` (diesel should bite); oil chunks all enabled with default scarcity multipliers |
| [x] | `aeronautics-server.toml` | Defaults — hot air burner (500) and steam vent (5000) lift caps gate airship size, matching "earn your flight". Propeller physics inherited from AoCA tuning intentionally |

---

## Tier 2 — World Gen (lock in before generating world)

| Done | Config | Notes |
|------|--------|-------|
| [x] | `tectonic.json` | Defaults — dramatic terrain matches "world worth flying over"; vertical_scale=1.125, ultrasmooth=false |
| [x] | `terrablender.toml` | Defaults — region size 3, vanilla weight 10 vs modded weights; balanced biome diversity |
| [x] | `lithostitched.json` | Defaults — `breaks_seed_parity=true` enables custom wood shipwrecks + structure optimizations (worth the seed-parity cost) |
| [x] | `biomeswevegone/` (dir) | Defaults — all 50+ biomes enabled (`eroded_borealis=false` ships disabled), region_weight=8, vanilla_additions=true |
| [x] | `natures_spirit-common.toml` | Defaults — all cozy biomes (sugi, lavender, wisteria, marigold, maple woodlands) enabled |
| [x] | `ecologics-common.toml` | Defaults — coconut crabs, prickly pears, azalea log replacement |
| [x] | `environmental-common.toml` | Defaults — pinecone golems, deer flower-breeding, koi serenity, muddy pigs, larger pig/hoglin litters |
| [x] | `autumnity-common.toml` | Defaults |
| [x] | `upgrade_aquatic-common.toml` | Defaults — **renewable sand via cobblestone+magma+bubble columns** is a Create-style automation primitive |
| [x] | `wildernature-common.toml` | Defaults — replaces vanilla biome animals with WilderNature equivalents (deer, owl, raccoon, bison, etc.) |
| [x] | `meadow-common.toml` | Defaults |
| [x] | `beachparty-common.toml` | Defaults — palms, seashells, sandwaves, message-in-a-bottle |
| [x] | `regions_unexplored/` (dir) | Defaults — all 60+ overworld biomes + cave + nether biomes enabled |
| [x] | `sereneseasons/` (dir) | Defaults. **Critical preserved:** `progress_season_while_offline=true` (essential for MP); `out_of_season_crop_behavior=0` (grow slowly, not fail — automation still functions, growth lamps are the engineering response); 8-day sub-seasons = 96-day full cycle |
| [x] | `cristellib/` (dir) | Defaults — auto-config on; t_and_t waystones/wwoo patches are conditional on those mods being installed (no-op for us) |
| [x] | `betterdungeons-neoforge-1_21.toml` | Defaults — small Nether dungeons off (avoid clutter), skull/heads/nether-blocks decorations on |
| [x] | `betterfortresses-neoforge-1_21.toml` | Defaults — vanilla Nether fortresses correctly disabled |
| [x] | `betterfortresses/` (dir) | Defaults |
| [x] | `bettermineshafts-neoforge-1_21.toml` | Defaults — vanilla mineshafts disabled, ore deposits enabled with vanilla-tier rarities |
| [x] | `betterstrongholds-neoforge-1_21.toml` | Defaults — `Enable Structure Ruin=false` (strongholds stay pristine) |
| [x] | `betterstrongholds/` (dir) | Defaults |
| [x] | `betterendisland-neoforge-1_21.toml` | Defaults — `Resummoned Dragon Drops Egg=false` (no easy egg farm; preserves end-game progression) |
| [x] | `idas-neoforge-1_21.toml` | Defaults — vanilla desert pyramid disabled, **`Disable Ice and Fire Structures=true` (correct, we don't have I&F mod)**, mining fatigue in labyrinth on |
| [x] | `integrated_villages-neoforge-1_21.toml` | Defaults — vanilla villages disabled, **`Activate Create Contraptions=true`** (windmills auto-spin in fresh villages — cozy charm) |
| [x] | `repurposed_structures-neoforge/` (dir) | Defaults — `importModdedItems=true` (RS chests pull modded loot from vanilla structure tables) |
| [x] | `towns_and_towers/` (dir) | **Changed:** `structure_rarity_new.json5` separation 12→24 for both `towers` and `towns`. Lens: vanilla 24-chunk separation keeps each settlement a destination, supporting "transport is progression" — meaningful rail journeys. All village/outpost variants enabled |
| [x] | `vanilla_structures/` (dir) | Defaults — vanilla toggle list left on; mod-level disables (Better Fortresses, IDAS, Integrated Villages) override correctly |
| [x] | `structureessentials.json` | Defaults — `mapSearchRadius=40` (down from vanilla 50, perf), `globalSearchRadius=70`, `spacingSeparationModifier=1.0`. `autoBiomeCompat.enableBiomeCompat=false` — **revisit at launch** if modded biomes feel structure-starved |
| [x] | `lootintegrations.json` | Defaults — `moddedItemWeight=3` (modded loot 3x more likely; rewards exploration in a modded pack); `skipMapItems=true` (perf) |

---

## Tier 2 — Multiplayer Systems

Re-analyzed through the trusted-MP, no-punishing-loss, collaborative-engineering lens. Defaults are extraordinarily well-aligned — these are the cleanest configs in the pack.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `ftbteams-server.snbt` | Defaults — `limited_lives=0` (no party-life punishment) |
| [x] | `ftbxmodcompat.snbt` | Defaults — auto-detect selectors; `only_show_known_waystones=true` is no-op (no waystones mod) |
| [x] | `railways-common.toml` | Defaults — `disableDatafixer=false` (safe migration), `registerMissingTracks=false` (clean registry) |
| [x] | `railways-server.toml` | **Changed:** `realisticTrains=false→true`. Lens: parallel logic with diesel engines requiring fuel — trains are now a real fuel-logistics challenge, not a free service. Also preserved: `creeperTrackDamage=false` (rail investment protected), `mustOwnBoundTrain=false` (collaborative train use), `flipDistantSwitches=true` (engineering utility), `realisticFuelTanks=true` |
| [x] | `createrailwaysnavigator-common.toml` | Defaults — `global_settings_permission_level=0` (collaborative network ownership), `admin_mode_permission_level=3` (admin features OP-only), `use_new_simulation_algorithm=false` (stability-first) |
| [x] | `voicechat/` (dir) | **Changed:** `allow_recording=true→false` (privacy default — record only with explicit opt-in). Defaults preserved: 48-block proximity / 24-block whisper (workshop scale), `enable_groups=true` (private channels for sub-teams), `force_voice_chat=false` (vanilla clients welcome) |
| [x] | `lootr-common.toml` | Defaults — `randomise_seed=true` (per-player loot, no race-to-loot), mineshafts and item frames converted, no decay (cozy pacing), `bypass_spawn_protection=true`, elytras stay in item frames (preserves the awe of finding one) |
| [x] | `corpse-server.toml` | Defaults — `death_storage_duration=-1` (infinite), `force_time=-1` (corpses never auto-despawn — vacationing players can return to recover), `fall_into_void=false`, `lava_damage=false`, `only_owner=false` (friends can recover for each other). Critical for "no punishing loss when you fall off your airship" |
| [x] | `NoChatReports/` (dir) | Defaults — `demandOnClient=false` (vanilla clients can join), `convertToGameMessage=true`, `addQueryData=true` (server lists itself as NCR-protected). Privacy-from-Mojang, not player policing |

---

## Tier 3 — Create Addons

Reviewed through the design lens. The major design tension here was **jetpacks (Create: Stuff 'n Additions)** vs. the "Aeronautics is the only aerial travel" rationale. After researching: Andesite/Copper jetpacks are movement-boost tier (height 18, fuel-gated), Brass/Netherite are flight tier (height 28, steam fuel, lava-swim for Netherite). Decision: **accept defaults — jetpacks are fuel-gated Create vocabulary; the fuel-tank-burn loop is itself Create engineering.** This decision is recorded so future reviews don't re-litigate it.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `create_enchantment_industry-server.toml` | Defaults — Deployer XP collect on, Printer for enchanted books, Experience Lantern 10-block pull. `ignoreEnchantmentCompatibility=true` is the mod's central feature (Super Enchanting); kept |
| [x] | `create_connected-common.toml` | Defaults — all features on (additive engineering vocabulary: kinetic bridge, fluid vessel, item silo, kinetic battery, etc.) |
| [x] | `create_connected-server.toml` | Defaults — `vesselMaxLevel=18` (matches vanilla boilers); `batteryCapacity=512.0 su-hours`; `allowDualWildcardLink=false` (interpretable redstone signals) |
| [x] | `create_deep_dark-common.toml` | Defaults — `strong_armor`/`strong_sword=true` (deep dark exploration rewarded) |
| [x] | `dragonlib-common.toml` | Defaults — caching NORMAL, auto-adjust time system |
| [x] | `dragonlib-server.toml` | Defaults — auto-detect time-changing mods |
| [x] | `create_dragons_plus-common.toml` | Defaults — dye fluids, dragon's breath, sand-paper polishing for polished/oxidized/waxed blocks. `blaze_upgrade_smithing_template=false` (no-op without target mods) |
| [x] | `create_dragons_plus-server.toml` | Defaults — Bulk Coloring/Freezing/Sanding/Ending all on |
| [x] | `create_dragons_plus-simulated-extension-common.toml` | Defaults — fluid air-current interaction, fragile fluid tank |
| [x] | `create_dragons_plus-simulated-extension-server.toml` | Defaults — fragile tank lava-ignite + dye-color; bulk blasting/splashing/coloring block-interactions on |
| [x] | `create_aquatic_ambitions-server.toml` | Defaults — conduit cage 32-block radius, 20s/bucket water awakening, 2-hour accumulation max |
| [x] | `create_central_kitchen-common.toml` | Defaults — **all Farmer's Delight/Brewin'/Extra Delight recipe bridges enabled.** Critical for the cozy-food automation loop |
| [x] | `create_integrated_farming-server.toml` | Defaults — Chicken Roost 9 slots × 1 item (forces chained roosts = engineering as infrastructure); Fishing Net 8x cooldown + 8 valid blocks (anti-stationary-trap) |
| [x] | `create_fantasizing-server.toml` | Defaults — Block Placer is a Create machine (power+cooldown+infrastructure-required), range 48, Infinity/Fortune/Silk Touch enchant compat. Engineered tool, not creative wand |
| [x] | `create-stuff-additions.toml` | Defaults accepted after design review. **Jetpack tiers:** Andesite/Copper at height 18 are movement boosts (heat/hydraulic fuel); Brass at 28 is real flight (steam fuel); Netherite at 28 adds lava swim. Hover mode supported. Treated as fuel-gated Create vocabulary; Aeronautics remains the milestone for sustained aerial transport |
| [x] | `createfastschematiccannon-common.toml` | Defaults — `EnableCannonSpeedUp=true`, `SpeedupPerTick=20`, `lazyTick=5` (~40x faster prints). Pure QoL on MP — schematic prints are utility, not gameplay. Blacklists `create:blaze_burner` to prevent infinite-boiler bug |
| [x] | `createfood-server.toml` | Defaults — egg-yolk separation, cocoa pressing, cloth sack/ration box inventories |
| [x] | `createcasing-common.toml` | Defaults — casing/shaft swap enabled, wooden shafts break at speed 32 (engineering consequence) |
| [x] | `sliceanddice-common.toml` | Defaults — `harvester uses_knife=true`, `consume_tool_durability=true`, basin cooking HEATED |
| [x] | `mechanical_botany-server.toml` | Defaults — Mechanical Insolator processes saplings (auto-tree farming = automation-as-infrastructure for forestry) |
| [x] | `gnkinetics-server.toml` | Defaults — chain length 32, 6 connections per cog (extends Create kinetics vocabulary) |
| [x] | `simulated-server.toml` | **Stale config** — Create: Simulated base mod not installed (only Dragons+ Simulated Extension is). File will be ignored |
| [x] | `offroad-server.toml` | **Stale config** — offroad mod not installed in `/mods/`. File will be ignored |
| [x] | `escalated-server.toml` | Defaults — `maxWalkwayLength=128`, `maxEscalatorHeight=32`. Matches AoCA rationale: escalators are "slow, visible, part of architecture" — kept intentionally as the agency-preserving alternative to Hypertubes |
| [x] | `someassemblyrequired-server.toml` | Defaults — sandwich/burger effect duration scales with unique ingredients (encourages diverse farms) |

---

## Tier 3 — Storage & Inventory

| Done | Config | Notes |
|------|--------|-------|
| [x] | `sophisticatedbackpacks-common.toml` | Defaults — `chestLootEnabled=true` (rewards exploration) |
| [x] | `sophisticatedbackpacks-server.toml` | Defaults — Leather→Netherite tier progression (27→120 slots, 1→7 upgrade slots); `allowOpeningOtherPlayerBackpacks=true` (trusted MP cooperative); upgrade caps (jukebox×1, furnace×1, stack×3) |
| [x] | `sophisticatedcore-common.toml` | **Changed (3):** `inception_upgrade=false` (recursive bag-of-holding); `everlasting_upgrade=false` (preserves a maintenance loop); `xp_pump_upgrade=false` (stacks shortcuts with Create Enchantment Industry's XP automation). All other upgrades enabled. Backpack tier slot caps (1/1/2/3/5/7) already constrain choice |
| [x] | `toms_storage-common.toml` | Defaults — `blockedMods/blockedBlocks` empty |
| [x] | `toms_storage-server.toml` | Defaults — `inventoryConnectorRange=16` (encourages building network infrastructure); progression: wireless 16 → beacon-powered wireless 64 → beacon-powered cross-dim. Each tier requires real building |
| [x] | `accessories.json5` | Defaults — `useExperimentalCaching=false` (stability-first) |
| [x] | `curios-common.toml` | Defaults — `slots=[]` (mods register their own) |
| [x] | `curios-server.toml` | Defaults — `keepCurios="DEFAULT"` follows keepInventory; works correctly with Corpse mod handling death loot |
| [x] | `carryon-common.toml` | Defaults — **critical:** `forbiddenTiles` blacklist includes `"create:*"` + `"create*:*"` so Create blocks can't be picked up and moved. Forces in-place construction or contraptions. Also blocks FD/sophisticated/functional storage. `heavyTiles=true`+`heavyEntities=true` (carrying slows you, authentic) |
| [x] | `trashcans-common.toml` | Defaults — `allowVoidingNuclearWaste=false` (no nuclear mod, no-op) |
| [x] | `trashslot-common.toml` | Defaults — `instantDeletion=false` (no accidents), `enableDeleteKeysInCreative=true` |

---

## Tier 3 — Progression & Enchanting

Re-analyzed for feature overlap with other installed mods (Sophisticated Backpacks, Easy Magic, Corpse) and exploration-vs-trivialization tradeoffs on compasses.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `easymagic-common.toml` | Defaults — vanilla enchanting tables replaced in worldgen, old ones disabled |
| [x] | `easymagic-server.toml` | Defaults — bookshelf-15 power (vanilla), reroll on (1 lapis + 5 XP points), `chiseled_bookshelf=FACING`. Aligns with "engineering depth replaces grind" |
| [x] | `easyanvils-common.toml` | Defaults — vanilla anvils replaced |
| [x] | `easyanvils-server.toml` | Defaults — `too_expensive_limit=-1` (no anvil wall on long-term MP), `halved_book_costs=true`, `prior_work_penalty=LIMITED` (+4/op cap), `risk_free_anvil_renaming=true`, `anvil_break_chance=0.05` (down from vanilla 0.12). All defensible QoL on an engineering-grind-replacement pack |
| [x] | `quark-common.toml` | **Changed (4):** `[oddities] Backpack=false` (overlap with Sophisticated Backpacks); `[oddities] "Matrix Enchanting"=false` (overlap with Easy Magic — chosen progression); `[oddities] "Totem Of Holding"=false` (overlap with Corpse mod); `[tools] "Gold Tools Have Fortune"=false` (preserve enchantment progression, no built-in Fortune II shortcut). Other tweaks default-on |
| [x] | `zeta-common.toml` | Defaults — `Use Anti Overlap=true`, piston push limit 12 |
| [x] | `explorerscompass-common.toml` | **Changed:** `displayCoordinates=true→false`. Compass points but doesn't reveal coords — player must travel to find target. Aligns with "transport is progression / exploration rewards engineering." `allowTeleport=true` kept (OP/creative-only, fine for trusted-MP admin use) |
| [x] | `naturescompass-common.toml` | **Changed:** `displayCoordinates=true→false`. Same reasoning |
| [x] | `tradingpost-server.toml` | Defaults — 24×16 search range (build a villager hall in range = engineering-as-infrastructure for the trading economy); `teleport_xp=true` |

---

## Tier 4 — Food & Farming

All defaults align with engineering-replaces-grind philosophy.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `farmersdelight-common.toml` | Defaults — FD trades on, rope reeling, rich soil 20% bone meal boost, FD chest loot (rewards exploration), village compost heaps + FD crops in villages |
| [x] | `chefsdelight-common.toml` | Defaults — cook/chef house spawn weights per biome (Chef House Desert highest at 10) |
| [x] | `herbalbrews-common.toml` | Defaults — drying 45s, brewing 60s, hat 40% magic damage reduction |
| [x] | `ends_delight-common.toml` | Defaults — Dragon Tooth knife buff vs ender mobs; `enableGristleTeleport=true` (consumable Enderman drop, treated as enhanced enderpearl — vanilla-tier travel, not waystone-tier) |
| [x] | `cropsloverain.toml` | Defaults — `rain_growth_speed=10` (10x faster in rain). Aggressive but rain is occasional; complements Serene Seasons. Power Grid growth lamps remain the engineered response to winter |
| [x] | `realisticbees.json5` | Defaults — bees 25% size, 9 extra spawns per natural, 20 bees/hive (cozy aesthetic) |
| [x] | `universalbonemeal-server.toml` | Defaults — all bone meal interactions on (automation-as-infrastructure for seeding diverse plant types) |
| [x] | `vinery.toml` | Defaults — 5min fermentation, wine has years/effect levels, wandering trader 50% spawn |

---

## Tier 4 — Decoration & Ambience

All defaults align with the cozy-engineering aesthetic. No conflicts found.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `supplementaries-common.toml` | Defaults — all redstone/decoration features on, speaker 64-block range, bellows for fire-pushing. ("Supplementaries is non-negotiable" per rationale) |
| [x] | `suppsquared-common.toml` | Defaults — plaques + lanterns enabled |
| [x] | `amendments-common.toml` | Defaults — improved lectern, fireball gravity+cooldown, throwable fire charges, enhanced cauldron with hand-crafting and dye mixing |
| [x] | `amendments-client.toml` | Defaults — 3D projectiles, pixel-consistent signs, dragon-breath emissive |
| [x] | `beautify-server.toml` | Defaults — blinds 6-block search, Botanist Villager spawn weight 2 |
| [x] | `dndecor-server.toml` | Defaults — stress values for colored Create variants |
| [x] | `dndesires-server.toml` | Defaults — Industrial Fan 30-block range, faster processing (75 ticks vs Create's 150) — addon depth |
| [x] | `Dusty Decorations Config.toml` | Defaults — mob skull/hide/bone drops at low chances (2.5-5%) |
| [x] | `gallery-common.toml` | Defaults — paintings drop variants only with Shears/Silk Touch (engineering-as-infrastructure for art) |
| [x] | `copycats-common.toml` | Defaults — all copycat variants on. **Critical:** "dress Create blocks in any texture" rationale |
| [x] | `copycats-server.toml` | Defaults — copycat shaft/cogwheel stress values 0 |
| [x] | `sootychimneys-common.toml` | Defaults — smoke 75%, dirty chance 5%, wind affects smoke. ("chimney smoke makes a building feel occupied from a distance" rationale) |
| [x] | `pipeorgans-server.toml` | Defaults — MIDI upload 256KB limit, 16 files per player |
| [x] | `visualworkbench-common.toml` | Defaults — vanilla workbenches replaced for visual consistency |
| [x] | `doubledoors.json5` | Defaults — recursive opening 10 blocks; only doors on (fence gates + trapdoors off). `enableModIncompatibilityCheck=true` auto-disables Quark's double-door feature (explains the earlier observation) |
| [x] | `rightclickharvest.json5` | Defaults — `requireHoe=false`, `harvestInRadius=true`, no hunger/XP cost. RCH is for manual harvesting moments; Create harvesters handle automated farms |
| [x] | `sable-common.toml` | Defaults — sub-level networking framework for Aeronautics |
| [x] | `personality-common.toml` | Defaults — equipable banners, falling snow layers. (Mod IS installed despite earlier plan.md note saying "skipped") |
| [x] | `friendsandfoes.json` | Defaults — all mobs enabled (Beekeeper, Copper Golem, Crab, Glare, Iceologer, Illusioner, Mauler) with sensible spawn weights/biomes. "Friends & Foes populate the wilderness" rationale |
| [x] | `CoroUtil/` (dir) | Defaults — General.toml just has logging toggles |

---

## Tier 4 — QoL & Misc (likely fine at defaults)

All defaults align. No changes needed.

| Done | Config | Notes |
|------|--------|-------|
| [x] | `comforts-common.toml` | Defaults — hammock + sleeping bag recipes on |
| [x] | `comforts-server.toml` | Defaults — `autoUse=true`, hammocks day-only, sleeping bags night-only, `sleepingBagBreakChance=0` (cozy, no item loss), phantoms suppressed by attempted sleep |
| [x] | `jade/` (dir) | Defaults — empty plugin override; sort-order untouched |
| [x] | `jamlib/` (dir) | Defaults — known_suspicious_jars list |
| [x] | `simplehats.json` / `simplehats.json5` | Defaults — `keepHatOnDeath=true` (cozy, no losing your hat), mob+chest loot enabled |
| [x] | `pickupnotifier/` (dir) | Defaults — `partial_pick_ups=true`, `backpack_integration=true` |
| [x] | `xaero/` (dir) | Defaults left in xaero subdirs (minimap, world-map, lib) |
| [x] | `surveyor.toml` | Defaults — all systems DYNAMIC, `globalSharing=false` (per-player waypoints with `/surveyor share` opt-in for trusted MP) |
| [x] | `camerapture.server.json` | Defaults — 500KB max image, 1920px resolution, anyone can upload (trusted MP) |
| [x] | `sound_physics_remastered/` (dir) | Defaults — physically-correct attenuation (1.0), default reverb settings |
| [x] | `watut-common.toml` | Defaults — idle after 5min |
| [x] | `watut-server.toml` | Defaults — all social-presence features on (typing animation, idle status, GUI peek at 10-block distance) |
| [x] | `watut-client.toml` | Defaults — all per-client social-presence visibility on |
| [x] | `watut-item-arm-adjustments.json` | Default item arm positions |
| [x] | `moonlight-common.toml` | Defaults — multi-threaded generation, faster cache search |
| [x] | `blueprint-common.toml` | Defaults — `default_modded_biome_slice_size=8` |
| [x] | `collective.json5` | Defaults — update checker on, find-block check 30s delay |
| [x] | `cupboard.json` | Defaults — `forceHeapDumpOnOOM=false` (heap dumps are big) |
| [x] | `creativecore.json` | Defaults — gamemode user groups |
| [x] | `mcqoy.toml` | Defaults — Star Trek themed easter-egg config (harmless) |
| [x] | `jei-server.toml` | Defaults — cheat mode for OP+Creative, OFF for /give-permission. OK for Phase 6 dev; revisit at launch if abuse becomes a concern |
| [x] | `chunky/` (dir) | Defaults — `continueOnRestart=false`, `silent=false`. No specific pre-gen tasks configured (will be set when world generated) |

---

## Dropped Mods (configs may still exist on disk)

| Config | Reason dropped |
|--------|---------------|
| ~~`despawntweaks-common.toml`~~ | Data component registry conflict — blocks client connection |
| ~~`quark-common-1.toml.bak`~~ | Backup file from Quark update, not a live config |
