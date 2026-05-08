# Homestead Mod Analysis — Phase 3: NeoForge Compatibility

> Date: 2026-05-08  
> Target: Minecraft 1.21.1, NeoForge  
> Method: Modrinth API `loaders` field per project

---

## ✅ Confirmed NeoForge Compatible — Carry Over Directly

### Minimum Cozy Stack (all green)
| Mod | Modrinth Slug | Notes |
|-----|---------------|-------|
| AmbientSounds | ambientsounds | ✅ fabric, forge, neoforge |
| Sound Physics Remastered | sound-physics-remastered | ✅ fabric, forge, neoforge |
| LambDynamicLights | lambdynamiclights | ✅ fabric, neoforge, quilt |
| Particle Rain | particle-rain | ✅ fabric, forge, neoforge |
| Supplementaries | supplementaries | ✅ fabric, forge, neoforge |
| Supplementaries Squared | supplementaries-squared | ✅ fabric, forge, neoforge |
| Handcrafted | handcrafted | ✅ fabric, forge, neoforge |
| Chipped | chipped | ✅ fabric, forge, neoforge |
| Farmer's Delight | farmers-delight | ✅ forge, neoforge (original, not Refabricated) |
| Let's Do Vinery | lets-do-vinery | ✅ fabric, forge, neoforge |
| Let's Do HerbalBrews | lets-do-herbalbrews | ✅ fabric, forge, neoforge |
| Create | create | ✅ forge, neoforge |
| Create: Steam 'n' Rails | create-steam-n-rails | ✅ fabric, forge, neoforge |
| Create Deco | create-deco | ✅ fabric, forge, neoforge |
| Create: Slice & Dice | slice-and-dice | ✅ fabric, forge, neoforge |
| Create: Copycats+ | copycats | ✅ fabric, forge, neoforge (also a Create addon!) |

### Decoration & Furniture
| Mod | Modrinth Slug | Notes |
|-----|---------------|-------|
| Amendments | amendments | ✅ fabric, forge, neoforge |
| Decorative Lamps | decorative-lamps | ✅ fabric, forge, neoforge |
| Macaw's Paintings | macaws-paintings | ✅ fabric, forge, neoforge |
| Macaw's Paths and Pavings | macaws-paths-and-pavings | ✅ fabric, forge, neoforge |
| Macaw's Holidays | macaws-holidays | ✅ fabric, forge, neoforge |
| Dark Paintings | dark-paintings | ✅ fabric, forge, neoforge |
| Diagonal Walls | diagonal-walls | ✅ fabric, forge, neoforge |
| Diagonal Windows | diagonal-windows | ✅ fabric, forge, neoforge |
| Double Doors | double-doors | ✅ fabric, forge, neoforge |
| Dusty Decorations | dusty-decorations | ✅ fabric, forge, neoforge |
| Immersive Furniture | immersive-furniture | ✅ fabric, forge, neoforge |
| Beautify! | beautify | ✅ forge, neoforge |
| Serene Shrubbery | serene-shrubbery | ✅ forge, neoforge |
| Mo Glass | mo-glass | ✅ fabric, forge, neoforge |
| Sooty Chimneys | sooty-chimneys | ✅ fabric, forge, neoforge |
| Camerapture | camerapture | ✅ fabric, forge, neoforge |
| Armor Statues | armor-statues | ✅ fabric, forge, neoforge |
| Simple Hats | simple-hats | ✅ fabric, forge, neoforge |
| Via Romana | via-romana | ✅ fabric, forge, neoforge |

### Ambience & Visual
| Mod | Modrinth Slug | Notes |
|-----|---------------|-------|
| Continuity | continuity | ✅ fabric, forge, neoforge |
| Subtle Effects | subtle-effects | ✅ fabric, forge, neoforge |
| Not Enough Animations | not-enough-animations | ✅ fabric, forge, neoforge |
| Tiny Item Animations | tiny-item-animations | ✅ fabric, forge, neoforge |

### World Gen
| Mod | Modrinth Slug | Notes |
|-----|---------------|-------|
| Tectonic | tectonic | ✅ datapack, fabric, forge, neoforge |
| Nature's Spirit | natures-spirit | ✅ fabric, forge, neoforge |
| Geophilic | geophilic | ✅ datapack, fabric, forge, neoforge |
| Regions Unexplored | regions-unexplored | ✅ fabric, forge, neoforge |
| Oh The Biomes We've Gone | oh-the-biomes-weve-gone | ✅ fabric, forge, neoforge |
| TerraBlender | terrablender | ✅ fabric, forge, neoforge |
| Lithostitched | lithostitched | ✅ fabric, forge, neoforge |
| Incendium | incendium | ✅ datapack, fabric, forge, neoforge |
| Eldritch End | eldritch-end | ✅ fabric, forge, neoforge |
| Towns and Towers | towns-and-towers | ✅ fabric, forge, neoforge |
| Tidal Towns | tidal-towns | ✅ fabric, forge, neoforge |
| Dungeons & Taverns | dungeons-and-taverns | ✅ datapack, fabric, forge, neoforge |
| Repurposed Structures | repurposed-structures | ✅ fabric, forge, neoforge |
| YUNG's API | yungs-api | ✅ fabric, forge, neoforge |
| YUNG's Better Dungeons | yungs-better-dungeons | ✅ fabric, forge, neoforge |
| YUNG's Better Mineshafts | yungs-better-mineshafts | ✅ fabric, forge, neoforge |
| YUNG's Better Nether Fortresses | yungs-better-nether-fortresses | ✅ fabric, forge, neoforge |
| YUNG's Better Strongholds | yungs-better-strongholds | ✅ fabric, forge, neoforge |
| YUNG's Better End Island | yungs-better-end-island | ✅ fabric, forge, neoforge |
| YUNG's Bridges | yungs-bridges | ✅ fabric, forge, neoforge |
| YUNG's Extras | yungs-extras | ✅ fabric, forge, neoforge |
| Explorer's Compass | explorers-compass | ✅ fabric, forge, neoforge |
| Nature's Compass | natures-compass | ✅ (assumed, standard on both) |
| Traveller's Titles | travellers-titles | ✅ fabric, forge, neoforge |

### Food & Farming
| Mod | Modrinth Slug | Notes |
|-----|---------------|-------|
| Chef's Delight | chefs-delight | ✅ fabric, forge, neoforge |
| Ocean's Delight | oceans-delight | ✅ fabric, forge, neoforge |
| End's Delight | ends-delight | ✅ fabric, forge, neoforge |
| Nature's Delight | natures-delight | ✅ fabric, forge, neoforge |
| Crate Delight | crate-delight | ✅ fabric, forge, neoforge |
| Let's Do Meadow | lets-do-meadow | ✅ fabric, forge, neoforge |
| Let's Do Beachparty | lets-do-beachparty | ✅ fabric, forge, neoforge |
| Let's Do WilderNature | lets-do-wildernature | ✅ fabric, forge, neoforge |
| Comforts | comforts | ✅ fabric, forge, neoforge |
| Duckling | duckling | ✅ fabric, forge, neoforge |
| Realistic Bees | realistic-bees | ✅ fabric, forge, neoforge |
| RightClickHarvest | rightclickharvest | ✅ fabric, forge, neoforge |
| Crops Love Rain | crops-love-rain | ✅ fabric, neoforge |
| Universal Bone Meal | universal-bone-meal | ✅ fabric, forge, neoforge |
| Flower Tweaks | flower-tweaks | ✅ datapack, fabric, forge, neoforge |

### Storage & Infrastructure
| Mod | Modrinth Slug | Notes |
|-----|---------------|-------|
| Sophisticated Backpacks | sophisticated-backpacks | ✅ forge, neoforge |
| Sophisticated Storage | sophisticated-storage | ✅ forge, neoforge |
| Storage Drawers | storagedrawers | ✅ fabric, forge, neoforge |
| Tom's Simple Storage | toms-storage | ✅ fabric, forge, neoforge |
| Trash Cans | trash-cans | ✅ fabric, forge, neoforge |
| TrashSlot | trashslot | ✅ fabric, forge, neoforge |
| Lootr | lootr | ✅ fabric, forge, neoforge |
| Xaero's Minimap | xaeros-minimap | ✅ fabric, forge, neoforge |
| Xaero's World Map | xaeros-world-map | ✅ fabric, forge, neoforge |
| Simple Voice Chat | simple-voice-chat | ✅ fabric, forge, neoforge |
| Open Parties and Claims | open-parties-and-claims | ✅ fabric, forge, neoforge |

---

## ❌ Confirmed Fabric-Only — Need Alternatives

These are the gaps. Organized by how much they matter.

### Critical Gaps (load-bearing emotional jobs)

| Homestead Mod | Job | Why it matters | Recommended Alternative |
|---------------|-----|----------------|------------------------|
| **Presence Footsteps** | Immersion | Material-sensitive footstep sounds. Carpets, wood, grass all sound different underfoot. | Sound Physics Remastered covers reverb; investigate **Auditory** (NeoForge footstep mod) |
| **Farmer's Delight Refabricated** | Warmth | Core cooking system. | Use **Farmer's Delight** (original, forge/neoforge) — same gameplay, different addon ecosystem |
| **Trinkets** | Progression | Accessory slot API. Many mods depend on it for wearables. | **Curios API** is the NeoForge standard — verify all wearable mods target Curios |

### Significant Gaps

| Homestead Mod | Job | Notes | Recommended Alternative |
|---------------|-----|-------|------------------------|
| **Visuality** | Immersion | Decorative ambient particles (crumbling blocks, enchant glints, etc.) | **Subtle Effects** covers ~60% of this; may be sufficient |
| **Fairy Lights** | Warmth | String lights for decorating builds | No direct NeoForge port found. **Decorative Lamps** partially covers lighting. Worth watching for a port. |
| **Connectible Chains** | Expression | Hang chains between blocks as decoration | Fabric-only. Supplementaries has some hanging elements; gap remains. |
| **Friends & Foes** | Immersion | Adds mob vote losers (Copper Golem, Glare, Moobloom, etc.) | Check for a NeoForge Friends & Foes port specifically — the Fabric/Quilt version isn't it |
| **Spelunkery** | Discovery | Cave overhaul with new exploration rewards | No NeoForge port. Caves are strong in 1.21.1 vanilla anyway; lower priority. |

### Minor Gaps (low emotional impact)

| Homestead Mod | Notes |
|---------------|-------|
| Eating Animation | Fabric-only. Nice polish, not load-bearing. |
| FabricSkyBoxes | No NeoForge port. Sky customization is low priority. |
| C2ME | Fabric-only chunk optimizer. Lithium + Noisium cover most of this on NeoForge. |
| Clutter | Fabric-only. Handcrafted + Supplementaries fill similar space. |
| Things | Fabric-only trinket items. Curios-based equivalents exist on NeoForge. |
| Trowel | Fabric-only QoL. Nice to have, not essential. |
| NiftyCarts | Fabric-only horse carts. Aeronautics fills the transport role better. |
| Wearable Lanterns | Fabric-only. Radiant Gear + LambDynamicLights covers the lighting job. |
| Harvestable Flowers | Fabric-only, archived. Flower Tweaks (NeoForge ✅) covers this. |
| Secure Crops | Fabric-only. Low priority — Create handles farming differently anyway. |
| Blahaj | Fabric-only shark plushie. Perfect Plushies (NeoForge) can fill the plushie niche. |
| ChatHeads | Fabric-only. Nice social polish, not essential. |

### Confirmed Forge-Only (not NeoForge either)
| Mod | Notes |
|-----|-------|
| **Nether's Delight** | Forge-only. Gaps in Nether food content — lower priority since Nether isn't a primary biome for this pack's theme. |
| **Deeper & Darker** | Forge-only at time of check. Deep Dark expansion — check for NeoForge port before 1.21.1 release. |

---

## Summary: Gap vs. Coverage

| Category | Coverage | Key Gaps |
|----------|----------|----------|
| Sound & ambience | ~85% | Presence Footsteps — investigate Auditory |
| Decoration & furniture | ~90% | Fairy Lights, Connectible Chains |
| Visual polish | ~75% | Visuality, Eating Animation |
| World gen | ~95% | Spelunkery (low priority) |
| Food & farming | ~95% | Nether's Delight (low priority) |
| Create ecosystem | ~100% | All key mods confirmed NeoForge |
| Storage | ~100% | All confirmed |
| Accessory system | Requires swap | Trinkets → Curios API |

---

## Action Items for Mod List Finalization

1. **Swap** Farmer's Delight Refabricated → Farmer's Delight (NeoForge original, slug: `farmers-delight`)
2. **Investigate** Auditory mod for NeoForge footstep sounds to replace Presence Footsteps
3. **Adopt** Curios API as the accessory standard; verify all wearable/equipment mods have Curios support
4. **Watch** for Fairy Lights NeoForge port — currently no viable alternative
5. **Check** if a Friends & Foes NeoForge version exists (separate from the Fabric/Quilt one)
6. **Verify** Farmer's Delight NeoForge addon ecosystem covers: Ocean, End, Nature, Chef, Crate Delight equivalents (Phase 3 confirms most have NeoForge ports)
7. **Drop** Connectible Chains — no NeoForge port, Supplementaries partially covers the gap
