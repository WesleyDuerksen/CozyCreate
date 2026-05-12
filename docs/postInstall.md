# CozyCreate — Post-Install Modlist

> Generated: 2026-05-09  
> Reflects the pack after the full cleanup installation pass against `research/results.md`.

---

## Differences from results.md

### Added this pass (19 mods)

The entire Create Automation & Machinery section was missing from the initial install. All available mods were added and validated against the server. Additionally added Distant Horizons and Measurements:

| Mod | Slug |
|-----|------|
| Create: Blaze Burner Fuels | `create-blaze-burner-fuels` |
| Create Encased | `create-encased` |
| Create: Factory | `create-factory` |
| Create: FastSchematicCannon | `create-fast-schematic-cannon` |
| Create: Framed | `create-framed` |
| Create: Mechanical Botany | `create-mechanical-botany` |
| Create: Metalwork | `create-metalwork` |
| Create: Misc and Things | `create-misc-and-things` |
| Create: Pattern Schematics | `create-pattern-schematics` |
| Create Stuff 'N Additions | `create-stuff-additions` |
| Create: Transmission! | `create-transmission!` |
| Create: Escalated | `escalated` |
| Create: Gears n' Kinetics | `gears-n-kinetics` |
| Create: Some Assembly Required | `some-assembly-required` |
| Noisium | `noisium` |
| CreateBetterFps | `createbetterfps` |
| Personality | `personality` |
| Distant Horizons | `distanthorizons` |
| Measurements | `measurements` |

### Dropped — incompatibility

| Mod | Reason |
|-----|--------|
| Nature's Delight | `RichSoilBlockMixin` targets a method removed in Farmer's Delight 1.3.1 — hard crash on boot. No fix available at current versions. |
| Despawn Tweaks | Registers `despawntweaks:despawntweaker_picked` as a data component type while marked server-side only. NeoForge syncs the component registry on login, blocking clients without the mod. |

### Not available for NeoForge 1.21.1

These mods were in `results.md` but have no NeoForge 1.21.1 release on Modrinth or CurseForge:

| Mod | Slug | Notes |
|-----|------|-------|
| Create: Bits 'n' Bobs | `bits-and-bobs` | No 1.21.1 build |
| Create: Rubberworks | `create-rubberworks` | No 1.21.1 build |
| Create: Copper Splashing | `create-copper-splashing` | No 1.21.1/NeoForge build |
| Alex's Mobs | `alexs-mobs` | No 1.21.1/NeoForge build |
| Eldritch End | `eldritch-end` | No 1.21.1/NeoForge build |
| Duckling | `duckling` | No 1.21.1/NeoForge build |
| Debugify | `debugify` | Fabric-only, no NeoForge port |

### Slug substitutions (same mod, different slug)

| results.md slug | Installed as | Notes |
|-----------------|-------------|-------|
| `create-steam-n-rails` | `create-steam-n-rails-1.21.1` | Version-qualified slug |
| `curios-api` | `curios` | NeoForge variant slug |
| `immediately-fast` | `immediatelyfast` | Slug variation |
| `repurposed-structures` | `repurposed-structures-forge` | Loader-qualified slug |
| `travellers-titles` | `travelers-titles` | Spelling variant |
| `oculus` | `iris` | Iris now natively supports NeoForge; Oculus deprecated |
| `embeddium` | `sodium` | Sodium now natively supports NeoForge; Embeddium superseded |
| `universal-graves` | `corpse` | Equivalent death-chest mod |

---

## Full Modlist

**Total: 230 mods** (including auto-pulled dependencies)

### Create Ecosystem

#### Core

| Mod | Slug | Role |
|-----|------|------|
| Create | `create` | Automation engine — the spine of the pack |
| Create: Aeronautics | `create-aeronautics` | Airships and aerial vehicles — the exploration pillar |
| Create: Diesel Generators | `create-diesel-generators` | Mid-game power; diesel-punk aesthetic |
| Create: Power Grid | `power-grid` | Late-game electrical distribution |
| Create: Steam 'n' Rails | `create-steam-n-rails-1.21.1` | Railways and steam systems |
| Create: Slice & Dice | `slice-and-dice` | Automates Farmer's Delight via Create machines |
| Create: Garnished | `create-garnished` | Nut trees and food items feeding into Create automation |
| Create: Enchantment Industry | `create-enchantment-industry` | Automates enchanting |
| Create: Bells & Whistles | `bellsandwhistles` | Decorative blocks for train stations |
| Create Deco | `create-deco` | Industrial decoration |
| Create: Copycats+ | `copycats` | Dress any Create block in any texture |
| Create: Dreams & Desires | `create-dreams-and-desires` | QoL and decorative pieces |

#### Automation & Machinery

| Mod | Slug | Role |
|-----|------|------|
| Create: Blaze Burner Fuels | `create-blaze-burner-fuels` | Extended Blaze Burner fuel sources |
| Create: Connected | `create-connected` | Connected textures for Create casings and shafts |
| Create Encased | `create-encased` | Encased shaft/block variants |
| Create: Factory | `create-factory` | Assembly presses, mold casting — late-game manufacturing |
| Create: FastSchematicCannon | `create-fast-schematic-cannon` | Schematic Cannon performance improvement |
| Create: Framed | `create-framed` | Camo blocks for Create machinery |
| Create: Gears n' Kinetics | `gears-n-kinetics` | Extended gear ratios, flywheels, kinetic storage |
| Create: Mechanical Botany | `create-mechanical-botany` | Automates tree farms and botanical processing |
| Create: Metalwork | `create-metalwork` | Extended metal processing — alloys and castings |
| Create: Misc and Things | `create-misc-and-things` | Windmill sails, chutes, small utility blocks |
| Create: Pattern Schematics | `create-pattern-schematics` | Reusable build patterns |
| Create Stuff 'N Additions | `create-stuff-additions` | Casings, dials, gauges |
| Create: Some Assembly Required | `some-assembly-required` | Assembly-line ordered crafting sequences |
| Create: Transmission! | `create-transmission!` | Universal joints, telescoping shafts |
| Create: Escalated | `escalated` | Escalators and inclined conveyors |

#### Food & Drink (Create-integrated)

| Mod | Slug | Role |
|-----|------|------|
| Create: Aquatic Ambitions | `create-aquatic-ambitions` | Underwater Create machinery |
| Create: Central Kitchen | `create-central-kitchen` | Kitchen automation block set |
| Create: Food | `create-food` | General food processing machines |
| Create: Integrated Farming | `create-integrated-farming` | Deep Farmer's Delight × Create integration |
| Create: Winery | `create-winery` | Wine production via Create machines |
| Create: Dragons Plus | `create-dragons-plus` | Required dependency for Central Kitchen + Enchantment Industry + Integrated Farming |

#### Industrial Decoration

| Mod | Slug | Role |
|-----|------|------|
| Create: Deep Dark | `create-deep-dark` | Deep dark materials for Create machines |
| Create: Design n' Decor | `create-design-n-decor` | Industrial pipes, gauges, panels |
| Create: Fantasizing Again | `create-fantasizing-again` | Holographic indicators and displays |
| Create: Industrialized Architecture | `industrialized-architecture` **[CurseForge]** | Girders, columns, catwalks |
| Create: Prismatic Shine | `create-prismatic-shine` | Light refraction through glass and crystal blocks |
| Create: Sound of Steam | `create-sound-of-steam` | Pipe organs, steam whistles, ambient machine sounds |
| Create: Vibrant Vaults | `create-vibrant-vaults` | Decorative vault and safe-door blocks |

#### Rail & Transport

| Mod | Slug | Role |
|-----|------|------|
| Create: Blocks & Bogies | `blocks-bogies` | Extended bogie types |
| Create Railways Navigator | `create-railways-navigator` | In-game train schedule, route, and arrival HUD |
| Create: Train Parts | `create-train-parts` | Additional train car types |

#### Aeronautics

| Mod | Slug | Role |
|-----|------|------|
| Sable | `sable` | Aeronautics companion library |

---

### Ambience & Audio

| Mod | Slug | Role |
|-----|------|------|
| AmbientSounds | `ambientsounds` | Environmental soundscapes |
| Sound Physics Remastered | `sound-physics-remastered` | Reverb and attenuation |
| Particle Rain | `particle-rain` | Atmospheric weather |

---

### Decoration & Furniture

| Mod | Slug | Role |
|-----|------|------|
| Supplementaries | `supplementaries` | Jars, sconces, signposts, planters |
| Supplementaries Squared | `supplementaries-squared` | Extended Supplementaries content |
| Handcrafted | `handcrafted` | 250+ furniture pieces |
| Chipped | `chipped` | 11,000+ block variants |
| Amendments | `amendments` | Vanilla block tweaks |
| Beautify! | `beautify` | Vanilla-styled building blocks |
| Camerapture | `camerapture` | In-game camera |
| Dark Paintings | `dark-paintings` | Additional painting variety |
| Decorative Lamps | `decorative-lamps` | Dimmable lamps with redstone support |
| Diagonal Walls | `diagonal-walls` | Diagonal architecture |
| Diagonal Windows | `diagonal-windows` | Diagonal windows |
| Double Doors | `double-doors` | Synchronized door pairs |
| Dusty Decorations | `dusty-decorations` | Rustic port/market blocks |
| Immersive Furniture | `immersive-furniture` | Custom furniture |
| Macaw's Paintings | `macaws-paintings` | Custom painting artwork |
| Macaw's Paths and Pavings | `macaws-paths-and-pavings` | Path and paving blocks |
| Macaw's Holidays | `macaws-holidays` | Seasonal decoration |
| Mo Glass | `mo-glass` | Glass stairs and slabs |
| Serene Shrubbery | `serene-shrubbery` | Garden plants and flowers |
| Simple Hats | `simple-hats` | Cosmetic hats |
| Sooty Chimneys | `sooty-chimneys` | Chimney smoke |
| Armor Statues | `armor-statues` | Poseable armor stands |
| Antique Atlas 4 | `antique-atlas-4` | Hand-drawn aesthetic world map |
| Quark | `quark` | Vanilla+ foundation |
| Gallery | `gallery` | Gallery-style framed art display |
| Personality | `personality` | Ambient creature expressions |
| Boatload | `boatload` | Additional boat types with storage |

---

### Visual Polish

| Mod | Slug | Role |
|-----|------|------|
| Continuity | `continuity` | Connected textures |
| Not Enough Animations | `not-enough-animations` | Third-person animations |
| Subtle Effects | `subtle-effects` | Ambient particles and sounds |
| Tiny Item Animations | `tiny-item-animations` | Item pickup animations |
| Iris | `iris` | Shader loader for NeoForge |
| Euphoria Patches | `euphoria-patches` | Complementary Shaders extension |
| Sodium Dynamic Lights | `sodium-dynamic-lights` | Dynamic lighting |

---

### World Gen & Adventure

| Mod | Slug | Role |
|-----|------|------|
| Tectonic | `tectonic` | Major terrain overhaul |
| Nature's Spirit | `natures-spirit` | New biomes and blocks |
| Geophilic | `geophilic` | Subtle vanilla biome polish |
| Regions Unexplored | `regions-unexplored` | Biome diversity |
| Oh The Biomes We've Gone | `oh-the-biomes-weve-gone` | More biome variety |
| Incendium | `incendium` | Nether overhaul |
| TerraBlender | `terrablender` | Biome compatibility library |
| Lithostitched | `lithostitched` | Worldgen compatibility library |
| Serene Seasons | `serene-seasons` | Seasons with shifting colors and temperatures |
| Autumnity | `autumnity` | Autumn biomes |
| Environmental | `environmental` | Blossom Woods and overworld biomes |
| Ecologics | `ecologics` | New biome mobs in vanilla aesthetic |
| Friends & Foes | `friends-and-foes-forge` | Mob vote losers including Copper Golem and Moobloom |
| Upgrade Aquatic | `upgrade-aquatic` | Ocean upgrades |
| Towns and Towers | `towns-and-towers` | New villages and outposts |
| Tidal Towns | `tidal-towns` | Floating ocean settlements |
| Dungeons & Taverns | `dungeons-and-taverns` | Dungeons and taverns |
| Repurposed Structures | `repurposed-structures-forge` | Structures adapted to every biome |
| Valhelsia Structures | `valhelsia-structures` | Additional world structures |
| Integrated Dungeons & Structures | `idas` | Large integrated structures |
| Integrated Villages | `integrated-villages` | Vanilla village overhaul |
| Structure Essentials | `structure-essentials-forge-fabric` **[CurseForge]** | Structure generation density config |
| Loot Integrations | `loot-integrations` **[CurseForge]** | Injects mod-appropriate loot into vanilla structure chests |
| YUNG's API | `yungs-api` | Required YUNG's library |
| YUNG's Better Dungeons | `yungs-better-dungeons` | Dungeon overhaul |
| YUNG's Better Mineshafts | `yungs-better-mineshafts` | Mineshaft overhaul |
| YUNG's Better Nether Fortresses | `yungs-better-nether-fortresses` | Nether fortress overhaul |
| YUNG's Better Strongholds | `yungs-better-strongholds` | Stronghold overhaul |
| YUNG's Better End Island | `yungs-better-end-island` | End island overhaul |
| YUNG's Bridges | `yungs-bridges` | Natural bridge structures |
| YUNG's Extras | `yungs-extras` | Scattered vanilla+ structures |
| Explorer's Compass | `explorers-compass` | Find structures by name |
| Nature's Compass | `natures-compass` | Find biomes by name |
| Traveller's Titles | `travelers-titles` | Biome/dimension title card on screen |
| Lootr | `lootr` | Per-player loot chests |

---

### Food, Farming & Cozy Life

| Mod | Slug | Role |
|-----|------|------|
| Farmer's Delight | `farmers-delight` | Core cooking system |
| Chef's Delight | `chefs-delight` | Chef villager profession |
| Ocean's Delight | `oceans-delight` | Ocean food content |
| End's Delight | `ends-delight` | End dimension food |
| Crate Delight | `crate-delight` | Decorative food storage |
| Let's Do Vinery | `lets-do-vinery` | Wine making |
| Let's Do HerbalBrews | `lets-do-herbalbrews` | Tea and coffee brewing |
| Let's Do Beachparty | `lets-do-beachparty` | Beach food and furniture |
| Let's Do Meadow | `lets-do-meadow` | Meadow sub-biomes and food |
| Let's Do WilderNature | `lets-do-wildernature` | Wildlife and hunting |
| Comforts | `comforts` | Sleeping bags and hammocks |
| Realistic Bees | `realistic-bees` | Better bee mechanics |
| RightClickHarvest | `rightclickharvest` | Right-click to harvest crops |
| Crops Love Rain | `crops-love-rain` | Rain speeds crop growth |
| Universal Bone Meal | `universal-bone-meal` | Bone meal on everything |
| Flower Tweaks | `flower-tweaks` | Flower breeding and crafting |

---

### Storage & Inventory

| Mod | Slug | Role |
|-----|------|------|
| Sophisticated Backpacks | `sophisticated-backpacks` | Tiered upgradeable backpacks |
| Tom's Simple Storage | `toms-storage` | Network-based centralized storage |
| Trash Cans | `trash-cans` | Void bins |
| TrashSlot | `trashslot` | Inventory delete slot |
| Carry On | `carry-on` | Pick up and carry chests and tile entities |

---

### QoL & Multiplayer

| Mod | Slug | Role |
|-----|------|------|
| Simple Voice Chat | `simple-voice-chat` | Proximity voice |
| FTB Quests | `ftb-quests-forge` **[CurseForge]** | Quest and reward system |
| FTB Filter System | `ftb-filter-system` **[CurseForge]** | Advanced item filter UI |
| FTB XMod Compat | `ftb-xmod-compat` **[CurseForge]** | FTB compatibility bridges |
| Jade | `jade` | Block/entity info HUD |
| Measurements | `measurements` | In-world distance and area measurement tool |
| JEI | `jei` | Recipe viewer |
| Just Enough Breeding | `justenoughbreeding` | JEI add-on: animal breeding |
| Just Enough Professions | `just-enough-professions-jep` | JEI add-on: villager trades |
| Just Enough Resources | `just-enough-resources-jer` | JEI add-on: drop rates and worldgen data |
| Xaero's Minimap | `xaeros-minimap` | Minimap |
| Xaero's World Map | `xaeros-world-map` | Full world map |
| Patchouli | `patchouli` | In-game guidebook |
| KubeJS | `kubejs` | Recipe and event scripting |
| CraftTweaker | `crafttweaker` | Recipe customization |
| AppleSkin | `appleskin` | Hunger/saturation display |
| Bad Wither No Cookie | `bad-wither-no-cookie` | Suppresses boss spawn sounds server-wide |
| Caelus API | `caelus` | Required dependency for Elytra Slot |
| Chat Heads | `chat-heads` | Player head icon in chat |
| Easy Anvils | `easy-anvils` | Removes anvil level cap |
| Easy Magic | `easy-magic` | Re-roll enchanting table options |
| Enchantment Descriptions | `enchantment-descriptions` | Enchant descriptions in tooltips |
| NetherPortalFix | `netherportalfix` | Fixes nether portal linking in multiplayer |
| Neruina | `neruina` | Prevents a broken ticking entity from crashing the server |
| No Chat Reports | `no-chat-reports` | Chat privacy |
| Pick Up Notifier | `pick-up-notifier` | Item pickup toast |
| Skin Layers 3D | `3dskinlayers` | 3D outer skin layer |
| Trading Post | `trading-post` | Multi-villager trading block |
| Visual Workbench | `visual-workbench` | Items visible on crafting table surface |
| What Are They Up To | `what-are-they-up-to` | See other players' held items |
| Chunky | `chunky` | Pre-generates world chunks server-side |
| Spark | `spark` | Performance profiling |
| Corpse | `corpse` | Preserve items on death |
| Polymorph | `polymorph` | Resolve conflicting recipes |
| Elytra Slot | `elytra-slot` | Dedicated elytra slot |
| Curios API | `curios` | NeoForge accessory standard |

---

### Performance

| Mod | Slug | Role |
|-----|------|------|
| Distant Horizons | `distanthorizons` | Level of Detail (LOD) renderer — distant terrain at low cost |
| Sodium | `sodium` | NeoForge rendering engine |
| Lithium | `lithium` | Game logic optimizations |
| ModernFix | `modernfix` | Memory and startup improvements |
| Noisium | `noisium` | Worldgen speed |
| Entity Culling | `entityculling` | Skip rendering hidden entities |
| ImmediatelyFast | `immediatelyfast` | Immediate mode rendering |
| FerriteCore | `ferrite-core` | Memory usage reduction |
| CreateBetterFps | `createbetterfps` | Create-specific rendering optimizations |
| AllTheLeaks | `alltheleaks` **[CurseForge]** | Memory leak collection fix |
| GPU Memory Leak Fix | `fix-gpu-memory-leak` **[CurseForge]** | GPU-side memory leak patching |
| Leaky | `leaky` **[CurseForge]** | Item entity rendering lag fix |
| Smooth Chunk Save | `smooth-chunk-save` **[CurseForge]** | Async chunk saving |
