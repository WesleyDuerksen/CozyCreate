# AoCA Study — Design Rationale (Phase 5)

> Date: 2026-05-08
> Purpose: Capture the *why* behind decisions made during the AoCA study, so future mod additions and removals can be evaluated against the same reasoning.

---

## What the AoCA Study Was For

The Homestead study built CozyCreate's cozy layer — decoration depth, ambience, food culture, world gen, and the emotional jobs each mod performs. The AoCA study was narrower: identify which Create-ecosystem mods AoCA uses that would deepen CozyCreate's engineering and automation identity without compromising its cozy, exploratory tone.

AoCA is not a reference for what CozyCreate should feel like. It's a reference for what the Create ecosystem is capable of. We took the engineering vocabulary and left the kitchen-sink philosophy.

---

## The Central Tension: Engineering Depth vs. Creative Agency

The most important filter applied throughout Phase 3 was not "does this mod fit the aesthetic" but "does this mod give the player something to engineer, or does it engineer for them?"

This distinction drove several of the most consequential cuts:

**Package Couriers / Mobile Packages** — Automated package delivery sounds like engineering. But it replaces the player's own logistics decisions with a pre-built system. A player who wants goods moved between workshops should build a contraption, a minecart line, or a steam train to do it. The creative tension of solving that problem *is the game*. A package routing system resolves the tension before it starts.

**Trading Floor** — Same principle. Automating villager trading removes the player's reason to build a trading hall, design a market district, or think about villager transportation. The manual act of trading is the social texture of the game.

**Hypertubes** — This one was harder. Hypertubes are genuinely built infrastructure — you construct the tube network. But the effect (instant player movement through a base) removes the experience of traversing the space you built. A workshop you can zip through in a second doesn't feel like a place. The Escalated escalators were kept because they're slow, visible, and become part of the architecture.

**Ornithopter Glider / Immersive Aircraft** — These shortcut the core premise of Aeronautics. The fantasy is that you build your aerial transport. A glider item or a pre-made aircraft mod hands you the result without the journey. The cozy-engineering loop requires that the player earns their flight.

**Mob Spawners** — Mob spawner automation gives players a solved system for something the game intends to be a creative challenge. How do you get mob drops at scale? That's a puzzle. Solving it with Create machines is fine — building a mob farm that's manually designed and mechanically driven is engineering. A mod that makes spawner *production* automated sidesteps the interesting part.

The pattern: when a mod removes a problem instead of giving you tools to solve it, it belongs in the skip pile.

---

## Power System: One Electricity Standard

CozyCreate runs two power systems that coexist without conflict:
- **Rotational power** (Create's native system — stress, RPM, shafts, gears)
- **Electrical distribution** (Create: Power Grid — grid-based transmission of Create's own power)

Everything else was cut. Create: New Age and Create Crafts & Additions both bridge Create's rotation to RF/FE (the legacy Forge power standard). We have no RF consumers. Adding an RF bridge invites RF consumers, which invites a third power ecosystem that dilutes the engineering identity of the pack. Power Grid was chosen precisely because it extends Create's own system rather than connecting to an outside standard.

This is a deliberate constraint. Players who want more power complexity can find that in other packs.

---

## Transport: Infrastructure, Not Systems

The transport philosophy established in the Homestead study — no teleportation, all travel must be built infrastructure — was extended and clarified during this study.

The clarification: the philosophy is not just about teleportation. It's about *agency*. Transport that the player designs, routes, and builds is progression. Transport that arrives as a ready-made system is a shortcut.

This is why Steam 'n' Rails stays and Package Couriers goes. Steam 'n' Rails gives you rail mechanics — players build the routes. Package Couriers builds the routes for you.

It's also why Escalated was kept while Hypertubes were cut. An escalator is infrastructure that becomes architecture. A hypertube is a fast-travel shortcut dressed in Create's aesthetic.

---

## Confectionery: Cozy Food Culture vs. Create Food Culture

AoCA handles food through Create — automated cafés, confectionery lines, chocolate fountains, mechanical kitchens. It works for their pack because food is fuel and automation is the point.

CozyCreate's food culture comes from the Homestead layer: Let's Do Vinery, HerbalBrews, Farmer's Delight, Comforts, the slow rhythm of cooking and sharing. The player-facing cooking loop is social and tactile. Create automates the *supply* (Slice & Dice, Integrated Farming, Garnished), but the act of making food remains something a player does with their hands at a crafting station or stove.

Adding Create: Café, Chocolate Fountain, Confectionery, and Mechanical Confection would shift food toward automation-as-the-experience rather than automation-as-infrastructure. The confectionery cluster was cut as a group because any one of them starts pulling the food identity in AoCA's direction.

What was kept from the Create food tier:
- **Central Kitchen + Integrated Farming** — These extend *processing* (turning raw materials into ingredients) which is squarely automation-as-infrastructure.
- **Create: Food** — General food processing machines; they serve as tools for building a kitchen workflow, not as the kitchen itself.
- **Create: Winery** — Pairs with Let's Do Vinery as the automated production end of a player-designed vineyard. The cozy aesthetic comes from Vinery; the engineering depth comes from Winery.

---

## Audio: Two Different Layers

AoCA uses Biome Music as its audio identity. CozyCreate uses AmbientSounds + Sound Physics Remastered.

The distinction matters: Biome Music plays *music tracks* per biome. AmbientSounds generates *environmental soundscapes* — wind in trees, water on rocks, cave drips, ambient pressure. Sound Physics makes every space acoustically distinct. These are fundamentally different audio layers.

Biome Music was cut for a second reason: it's a library that does nothing without a matching resource pack. AoCA ships their own branded resource pack to drive it. That content belongs to AoCA's identity, not ours.

The dynamic lighting swap (LambDynamicLights → Sodium Dynamic Lights) was a technical decision, not an aesthetic one. SDL is a purpose-built port of LambDynamicLights for the Sodium/Embeddium renderer pipeline. Same feature set, better integration with our actual renderer stack.

---

## The Create Decoration Layer

One of the most valuable things AoCA revealed: there is a distinct Create-aesthetic decoration vocabulary that CozyCreate was missing. The Homestead study covered cozy decoration (Handcrafted, Chipped, Supplementaries, the Macaw's series). It did not cover *industrial* decoration — the visual language of a working machine room.

Create: Industrialized Architecture (girders, catwalks, columns), Create: Design n' Decor (gauges, pipes, panels), Create: Sound of Steam (ambient machine noise), Create: Vibrant Vaults (vault doors), Create: Prismatic Shine (light through glass), and Create: Fantasizing Again (holographic indicators) together form a second decoration layer that makes engineering spaces look and feel like real industrial environments.

Without this layer, a CozyCreate build risks looking like a Handcrafted cottage with machinery bolted on. With it, you can build a workshop that reads as a workshop — and then put a kettle in the corner.

---

## Rail: Mature vs. Modular

AoCA's rail stack is modular: Blocks & Bogies + Train Parts + Railways Navigator, without Create: Steam 'n' Rails. The modular approach is more flexible but Steam 'n' Rails is the more established and comprehensive single mod.

CozyCreate keeps Steam 'n' Rails as the core rail system and adds:
- **Blocks & Bogies** — extended bogie variety on top
- **Train Parts** — more car types for diverse train consists
- **Create Railways Navigator** — multiplayer HUD (replaces Track Map)

This is the "both layers" answer: the stability of Steam 'n' Rails with the variety of the modular additions. Create: Track Map was dropped because Railways Navigator is a strict improvement — it does what Track Map does and adds schedule/arrival information that matters in multiplayer.

---

## What CozyCreate Is, Refined

The AoCA study sharpened the pack identity by contrast. AoCA is Create as the destination. CozyCreate is Create as the foundation.

In AoCA, you build machines because machines are the point. In CozyCreate, you build machines because the world is worth exploring, the food is worth making, the workshop is worth living in, and machines are how you get there.

The combined shortlist (Homestead Phase 4 + AoCA Phase 4 update) achieves:

- A **Create engineering spine** deep enough to provide years of progression
- A **cozy decoration and food layer** that makes every space worth inhabiting
- A **world worth flying over** — terrain, biomes, seasons, structures, creatures
- A **multiplayer infrastructure** that rewards building shared systems without forcing it
- **Audio and visual polish** that makes the world feel alive at rest, not just in motion

The pack is a cozy container around automation and exploration. The automation is the spine. The cozy is the container. Neither works without the other.
