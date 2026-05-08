# Homestead Mod Analysis — Phase 2: Emotional Jobs

> Date: 2026-05-08  
> Question: For each mod, what feeling does it create and is that feeling load-bearing?

## The 5 Emotional Jobs

| Job | Definition |
|-----|-----------|
| **Warmth** | Makes spaces feel lived-in, safe, inhabited |
| **Discovery** | Makes exploring feel rewarding and surprising |
| **Immersion** | Makes the world feel physically real and alive |
| **Expression** | Lets the player make their space feel like *theirs* |
| **Progression** | Gives a sense of getting stronger or building toward something |

---

## The Core "Feel" Stack

Highest value mods — most emotional work per slot. Removing any of these would noticeably degrade the cozy feel.

| Mod | Job | Why it's load-bearing |
|-----|-----|----------------------|
| **AmbientSounds** | Immersion | The forest breathes. Wind, insects, water. Removes the sterile silence of vanilla. #1 for "cozy." |
| **Sound Physics Remastered** | Immersion | Caves echo. Rain patters differently indoors. Every space sounds like itself. |
| **LambDynamicLights** | Warmth | Torches glow in hand. Fireflies light up. Changes the whole feel of nighttime. |
| **Particle Rain** | Immersion | Weather becomes atmospheric, not a wet debuff. Cozy indoors during storms. |
| **Supplementaries** | Warmth + Expression | Jars on shelves, signs on posts, sconces on walls — the mod that most makes a house feel *decorated*. |
| **Handcrafted** | Expression + Warmth | Tables, chairs, sofas, shelves. Rooms look furnished rather than empty. |
| **Chipped** | Expression | 11,000 block variants = any aesthetic is achievable. The "no compromise on style" mod. |
| **Farmer's Delight** | Warmth + Progression | Cooking loops give daily purpose. The kitchen becomes the heart of the base. |
| **Let's Do Vinery + HerbalBrews** | Warmth + Expression | Wine cellar, tea kettle, coffee corner — creates rituals and cozy room purposes. |

---

## High-Value, Replaceable

These do important jobs but have equivalents or close alternatives on NeoForge.

| Mod | Job | Notes for CozyCreate |
|-----|-----|----------------------|
| Chipped | Expression | ✅ NeoForge port exists — carry over |
| Macaw's suite | Expression + Warmth | ✅ All on NeoForge — carry over |
| YUNG's suite (6 mods) | Discovery | ✅ All on NeoForge — carry over wholesale |
| Tectonic | Discovery | ✅ NeoForge — carry over |
| Nature's Spirit | Discovery + Immersion | ✅ NeoForge — carry over |
| Presence Footsteps | Immersion | ❌ Fabric-only. Sound Physics partially covers it. Hunt a NeoForge footstep mod. |
| Visuality | Immersion | ❌ Fabric-only. Subtle Effects covers ~60% of the job. |
| Trinkets | Progression | ❌ Fabric-only. NeoForge uses **Curios API** — ensure wearable mods target Curios. |

---

## The Food/Farming Loop

Homestead's food system is deep (8+ Delight mods, 3+ Let's Do mods). The emotional job is **Warmth** — cooking gives daily ritual and reason to build a proper kitchen.

For CozyCreate:
- Replace **Farmer's Delight Refabricated** → **Farmer's Delight** (NeoForge original)
- Most addon mods (Ocean's, End's, Chef's, Nature's) have NeoForge ports — carry over
- **Let's Do** suite is mostly NeoForge-compatible — prioritize the beverage mods (Vinery, HerbalBrews)
- The cooking loop is the *social* layer; Create is the *progression* layer — they shouldn't compete. Create automates food supply, freeing players to focus on engineering.

---

## Mods to Drop

These don't serve CozyCreate's vision or are redundant.

| Mod | Reason |
|-----|--------|
| AlcoCraft+ | Overlaps with Vinery/HerbalBrews; not needed |
| Peaceful Hunger | CozyCreate needs stakes; hunger drives food system engagement |
| Smarter Farmers | Farming is automated by Create; villager farming AI is irrelevant |
| Pumpkins Accelerated | Create handles automation; redundant |
| BisectHosting Server Integration Menu | Hosting-specific |
| Modrinth Logo Mod | Cosmetic branding |
| InventoryHUD+ | Overlaps with Jade + AppleSkin |
| FabricSkyBoxes | No NeoForge port; low priority |
| Simple Discord RPC | Nice-to-have, not core |

---

## Mods to Amplify

Homestead uses these lightly; CozyCreate should lean into them.

| Mod | Job | How to amplify |
|-----|-----|----------------|
| **Create** | Progression | The spine of CozyCreate, not a garnish |
| **Create: Steam 'n' Rails** | Discovery + Expression | Rail networks between bases are social and architectural |
| **Create Deco** | Expression + Warmth | Make industrial builds look cozy, not grimy |
| **Patchouli** | Progression | In-game engineering progression guide |
| **Open Parties and Claims** | Warmth | Claimed areas feel owned and lived-in |
| **Simple Voice Chat** | Warmth | Proximity voice makes collaborative contraption-building feel real |

---

## The Minimum Cozy Stack

Mods that, if removed, would make CozyCreate feel like a generic Create pack. Everything else is additive.

1. **AmbientSounds** — non-negotiable for atmosphere
2. **Sound Physics Remastered** — non-negotiable for spaces feeling real
3. **LambDynamicLights** — non-negotiable for warm lighting
4. **Particle Rain** — high value, unique atmospheric weather
5. **Supplementaries** — non-negotiable for "dressed" spaces
6. **Handcrafted** — non-negotiable for furnished rooms
7. **Chipped** — high value for style flexibility
8. **Farmer's Delight** (NeoForge) + 3–4 addons — non-negotiable for cozy food loop
9. **Let's Do Vinery + HerbalBrews** — the "ritual" layer
10. **YUNG's suite** — non-negotiable for rewarding exploration
11. **Tectonic + Nature's Spirit** — world must look worth flying over in an airship
12. **Create ecosystem** — the unique differentiator from Homestead
