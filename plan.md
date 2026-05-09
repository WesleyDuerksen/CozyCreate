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
Every run: serves the pack locally via `packwiz serve`, syncs mods to `server/mods/`, starts the server, waits for the `Done (` ready signal, checks logs for ERROR/FATAL, stops the server, reports pass/fail.

The `server/` directory is gitignored — it's a local test artifact.

**Pass criteria:** server reaches ready state + zero errors/fatals in `server/logs/latest.log`.
**Acceptable warnings:** see `KNOWN_OK_PATTERNS` array in `validate.sh` — add false positives there as you find them.

### Client Test — Manual Checklist (Prism Launcher)

**One-time Prism bootstrap setup:**
1. Create a new NeoForge 1.21.1 instance in Prism Launcher (name it `CozyCreate-dev`)
2. In instance settings → **Custom commands** → Pre-launch command:
   ```
   "$INST_JAVA" -jar packwiz-installer-bootstrap.jar https://raw.githubusercontent.com/<your-repo>/main/pack.toml
   ```
   *(Until the repo is on GitHub, use the simple export method below)*
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

| Mod | Slug | Version | Notes |
|-----|------|---------|-------|
| Create | `create` | 6.0.10 | Core engine |
| Create: Aeronautics | `create-aeronautics` | 1.2.1 bundled | Auto-added: Sable |
| Create: Diesel Generators | `create-diesel-generators` | 1.3.11 | |
| Create: Power Grid | `power-grid` | 0.5.5.1 | Auto-added: Architectury API |
| Steam 'n' Rails NeoForge | `create-steam-n-rails-1.21.1` | 0.1.0 | Unofficial 1.21.1 fork — pinned to 0.1.0 (0.2.0-beta.2 crashes server with conductor entity bug) |

**Phase 1 gate — must pass before Phase 2:**
- [ ] `./validate.sh` → PASSED
- [ ] Client: title screen loads
- [ ] Client: create world → loads in
- [ ] Client: place a Mechanical Press, connect a shaft, run it — no crash
- [ ] Client: place a Diesel Generator, fuel it — no crash
- [ ] Client: connect to local test server → no crash

---

### Phase 2 — Create Addons (not yet started)
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
All slugs marked ⚠️ came from CurseForge during research — Modrinth availability needs verification before install.

| Mod | Slug | Status |
|-----|------|--------|
| Create: Bits 'n' Bobs | `bits-n-bobs` | ⚠️ verify |
| Create: Blaze Burner Fuels | `create-blaze-burner-fuels` | ⚠️ verify |
| Create: Escalated | `escalated` | ⚠️ verify |
| Create: Factory | `create-factory` | ⚠️ verify |
| Create: Fast SchematicCannon | `create-fast-schematic-cannon` | ⚠️ verify |
| Create: Framed | `create-framed` | ⚠️ verify |
| Create: Gears n' Kinetics | `gears-n-kinetics` | ⚠️ verify |
| Create: Mechanical Botany | `mechanical-botany` | ⚠️ verify |
| Create: Metalwork | `create-metalwork` | ⚠️ verify |
| Create: Pattern Schematics | `create-pattern-schematics` | ⚠️ verify |
| Create: Rubberworks | `rubberworks` | ⚠️ verify |
| Create: Some Assembly Required | `some-assembly-required` | ⚠️ verify |
| Create: Stuff 'n' Additions | `create-stuff-additions` | ⚠️ verify |
| Create: Transmission! | `create-transmission` | ⚠️ verify |
| Create Encased | `create-encased` | ⚠️ verify |
| Create: Misc & Things | `create-misc-and-things` | ⚠️ verify |
| Create: Copper Splashing | `copper-splashing` | ⚠️ verify |

**Batch E — Create Food & Drink**
| Mod | Slug | Status |
|-----|------|--------|
| Create: Aquatic Ambitions | `create-aquatic-ambitions` | ⚠️ verify |
| Create: Central Kitchen | `create-central-kitchen` | ⚠️ verify |
| Create: Food | `create-food` | ⚠️ verify |
| Create: Integrated Farming | `create-integrated-farming` | ⚠️ verify |
| Create: Winery | `create-winery` | ⚠️ verify |
| Create: Dragons Plus | `create-dragons-plus` | ⚠️ verify (dependency bundle) |

**Batch F — Create Decoration & Aesthetics**
| Mod | Slug | Status |
|-----|------|--------|
| Create: Deep Dark | `create-deep-dark` | ⚠️ verify |
| Create: Design n' Decor | `design-n-decor` | ⚠️ verify |
| Create: Fantasizing Again | `create-fantasizing` | ⚠️ verify |
| Create: Industrialized Architecture | `create-industrialized-architecture` | ⚠️ verify |
| Create: Prismatic Shine | `create-prismatic-shine` | ⚠️ verify |
| Create: Sound of Steam | `create-sound-of-steam` | ⚠️ verify |
| Create: Vibrant Vaults | `create-vibrant-vaults` | ⚠️ verify |
| Create Better FPS | `create-better-fps` | ⚠️ verify |

**Phase 2 gate — must pass before Phase 3:**
- [ ] `./validate.sh` → PASSED (all 6 batches installed)
- [ ] Client: title screen + world load — no crash
- [ ] Client: connected textures visible on Create casings (Batch A)
- [ ] Client: train placed on track, schedule set via Navigator — no crash (Batch C)
- [ ] Client: connect to local test server → no crash

---

### Phase 3 — Decoration & Ambience (not yet started)
Drawn from the Homestead shortlist. Full list in `research/homestead-phase4-shortlist.md`.
Install after Phase 2 is stable.

**Phase 3 gate — must pass before Phase 4:**
- [ ] `./validate.sh` → PASSED
- [ ] Client: title screen + world load — no crash
- [ ] Client: walk through a decorated space — no missing textures, no rendering crash
- [ ] Client: connect to local test server → no crash

---

### Phase 4 — Adventure & World (not yet started)
Exploration, structures, mobs. Full list in research files.
Install after Phase 3 is stable.

**Phase 4 gate — must pass before Phase 5:**
- [ ] `./validate.sh` → PASSED
- [ ] Client: title screen + world load — no crash
- [ ] Client: explore a new chunk — structures generate, no crash
- [ ] Client: connect to local test server → no crash

---

### Phase 5 — QoL & Performance (not yet started)
Sodium, Iris, and friends. Install alongside Phase 2 to make client testing playable.
Confirmed slugs (no ⚠️): `sodium-dynamic-lights`

**Phase 5 gate — must pass before Phase 6:**
- [ ] `./validate.sh` → PASSED
- [ ] Client: all of the above, now with shaders enabled (Iris) — no crash, acceptable FPS

---

### Phase 6 — Multiplayer Hardening (not yet started)
- Server-side config tuning
- Claim/grief protection review (no teleportation, no auto-claims — transport philosophy)
- Export final mrpack for Modrinth

**Phase 6 gate — ship criteria:**
- [ ] `./validate.sh` → PASSED
- [ ] Two clients connect to server simultaneously — no desync, no crash
- [ ] Fresh install from exported `.mrpack` works in Prism — no manual steps required
- [ ] Server runs for 10 minutes under light load — no memory leak, no OOM

---

## Key Decisions Log

- **Transport philosophy:** No teleportation or non-Create travel mods. All transport must be built infrastructure.
- **Power:** Create: Power Grid is the only electricity system. New Age and Crafts & Additions both cut.
- **Rails:** Steam 'n' Rails (unofficial 1.21.1 fork) + Blocks & Bogies + Train Parts. Navigator replaces Track Map.
- **Audio:** Sodium Dynamic Lights replaces LambDynamicLights.
- **Confectionery cluster cut:** Café, Chocolate Fountain, Confectionery, Mechanical Confection all removed.
- **Claims cut:** Aeronautics Claims and Open Parties and Claims both removed (trusted server).
