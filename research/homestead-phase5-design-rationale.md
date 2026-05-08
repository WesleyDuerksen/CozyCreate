# CozyCreate Design Rationale

> Date: 2026-05-08  
> Purpose: Document the *why* behind mod selection so future decisions stay consistent with the pack's identity.

---

## What CozyCreate Is (and Isn't)

CozyCreate is not a Homestead clone with Create bolted on. It's a different pack with a different thesis:

> **You are an engineer in a cozy workshop, building machines that do the work for you — not a farmer in a cottage doing it by hand.**

Homestead's loop is: tend your farm, cook your food, decorate your home. That's the point.  
CozyCreate's loop is: *automate* the farm, *automate* the food supply, then use the time and resources that frees up to build bigger, fly farther, and make your space more beautiful.

The cozy aesthetic isn't the goal — it's the *container* the engineering lives in. Every space should feel warm and lived-in, but the reason you're building those spaces is to house machines, not to roleplay a homesteader.

---

## Design Principles and How They Shaped the Mod List

### 1. Progression through engineering

Create is the spine of the pack, not a decoration. This drove several decisions:

- **Create: Slice & Dice** is in the list because it closes the loop between food production and automation — your kitchen runs off a conveyor belt.
- **Create: Enchantment Industry** is here because enchanting should be an engineering problem, not a grind. You build the system once; it runs forever.
- **Create: Diesel Generators + Power Grid** establish a power economy that rewards players for building infrastructure, not just placing machines.
- **Pam's HarvestCraft 2 was dropped** because 1000+ foods would trivialize the food automation loop. If everything is craftable with two ingredients in a crafting table, there's no reason to build a Create-powered kitchen. The Farmer's Delight ecosystem is curated and deep enough.
- **Smarter Farmers was dropped** because villager farming AI is irrelevant when Create automates the farm.

### 2. Every space should feel livable

The decoration layer exists to make engineering builds feel warm, not cold and industrial. This drove:

- **Supplementaries** is non-negotiable — it's the single mod most responsible for making a space feel *inhabited*. Jars on shelves, signs on posts, sconces on walls.
- **Handcrafted + Chipped** give players the vocabulary to build any style of room. Without them, creative builds hit a ceiling fast.
- **Create: Bells & Whistles** is the bridge between the two halves of the pack. Its 36 decorative blocks are specifically designed for train stations and engineering spaces — they make a Create build look like a place someone lives and works, not a factory floor.
- **Create Deco + Copycats+** let you dress any Create component in any texture. A steam boiler can look like it belongs in a Victorian workshop rather than a grey concrete cube.
- **Sooty Chimneys** — small detail, but chimney smoke makes a building feel occupied from a distance. Worth the slot.
- **Serene Seasons + Autumnity** make the world feel alive over time. A workshop in autumn feels completely different from one in winter. This matters for long-running multiplayer servers.

### 3. Exploration rewards engineering

The world needs to give players reasons to build expeditions and fly their airships. This shaped the world gen layer:

- **Tectonic** is the foundation — dramatic terrain means dramatic flight paths and meaningful destinations.
- **The full YUNG's suite** is included because rewarding dungeons, mineshafts, and structures make exploration worth the fuel cost.
- **Create: Aeronautics is the *only* aerial travel option.** No Immersive Aircraft, no other flying mods. If you want to fly, you build a flying machine. This is intentional — the first time a player launches a working airship should feel like a milestone, not a purchase.
- **Create: Steam 'n' Rails is the only fast ground travel option.** No Waystones, no Via Romana, no teleportation of any kind. You build the rail network; the rail network becomes infrastructure everyone benefits from. A server with a working rail system has achieved something together. A server with waystones has just placed some blocks.
- **Alex's Mobs + Friends & Foes** populate the wilderness so exploration feels alive rather than empty between structures.
- **Create: Track Map** makes the rail network visible as a shared achievement — players can see the network they've built grow on a live web map.

### 4. Stability over content

This is the most frequently violated principle in kitchen-sink modpacks and the one we're most committed to. Every mod on this list should be there for a specific reason.

Mods dropped for violating this principle:
- **Pam's HarvestCraft 2** — 1000+ foods with no Farmer's Delight compat bridge. Massive JEI clutter, recipe conflicts, and no design reason to have it alongside the existing Delight ecosystem.
- **AlcoCraft+** — fully redundant with Let's Do Vinery and HerbalBrews, which are better designed and better integrated.
- **Multiple Homestead ambient/particle mods** — Subtle Effects covers the ambient particle job well enough. Adding Visuality on top would be redundant noise.

Accepted gaps (where the right mod simply doesn't exist on NeoForge):
- **Presence Footsteps** — no NeoForge port exists (Auditory is also Fabric-only). Sound Physics Remastered covers reverb and space; the per-material footstep sounds are a gap we accept.
- **Fairy Lights** — no NeoForge port. Decorative Lamps + LambDynamicLights + Sooty Chimneys collectively cover the warm-lighting job.
- **Connectible Chains** — Fabric-only. Supplementaries has hanging elements that partially fill this.

### 5. Multiplayer-first, trusted server

The server is played by people who know and respect each other. This shaped the QoL layer:

- **Open Parties and Claims was dropped** — chunk protection and policing features aren't needed on a trusted server. They add complexity with no benefit.
- **No Chat Reports is kept** — this is about privacy from Mojang/Microsoft's reporting system, not about policing players against each other. Different concern, valid inclusion.
- **Simple Voice Chat is kept** — proximity voice makes collaborative engineering feel real. Working on a contraption together while talking is a qualitatively different experience.
- **FTB Quests is kept** — on a trusted server, quests aren't enforcement tools, they're a shared progression guide. Use them to surface engineering milestones ("build your first steam engine", "launch your first airship").

---

## The Food Loop's Role

Homestead uses food as the *primary* progression loop. CozyCreate uses it as the *social* layer.

The Farmer's Delight ecosystem + Let's Do suite exist to give the kitchen a purpose and to make cooking a ritual players choose to engage with, not a chore they skip. The wine cellar, the tea corner, the coffee setup in the workshop — these are room *types* that the mods enable, giving players reasons to decorate specific spaces.

Create: Slice & Dice means the actual crop-to-food pipeline can be fully automated. Players who want to engage deeply with cooking can; players who want to focus on engineering can automate the supply and just consume the output. Both are valid.

---

## The Transport Hierarchy

Travel in CozyCreate is deliberately tiered by engineering investment:

| Tier | Mode | Requirement |
|------|------|-------------|
| 0 | Walking / horse | Nothing |
| 1 | Rail network | Build Create: Steam 'n' Rails infrastructure |
| 2 | Airship | Build a Create: Aeronautics vehicle |

There is no teleportation. There are no shortcut travel mods. A player who invests in a rail network genuinely moves faster than one who hasn't. A player with an airship can reach places no rail line serves. This makes transport a progression system in itself, and it makes the infrastructure players build meaningful to everyone on the server.

---

## The Power Hierarchy

Similarly, power in CozyCreate has tiers:

| Tier | Source | Create mod |
|------|--------|------------|
| Early | Waterwheels, windmills | Create (base) |
| Mid | Diesel generators | Create: Diesel Generators |
| Late | Electrical grid | Create: Power Grid |

Players start with mechanical power from water and wind, graduate to diesel once they can refine fuel, and eventually build out an electrical distribution network. Each transition is an engineering milestone.

---

## What Makes This Different from "Just Adding Create to Homestead"

Homestead with Create added would be a pack where Create is optional content sitting alongside a manual homesteading loop. CozyCreate is a pack where Create is the reason the homesteading loop exists at all — the farm is an input to the machine, not the point of the game.

The decoration and ambience layer (the part borrowed most heavily from Homestead) exists to make the engineering feel cozy rather than sterile. The world gen layer exists to make the engineering feel purposeful — there are places worth flying to and resources worth automating the extraction of.

The result should feel like: a warm, beautiful world full of things to discover, where the way you engage with that world is by building increasingly sophisticated machines.
