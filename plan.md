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

### Phase 3 — Decoration & Ambience (not yet started)

Drawn from the Homestead shortlist. Full list in `research/homestead-phase4-shortlist.md`.
Install after Phase 2 is stable.

**Phase 3 gate — must pass before Phase 4:**

- [ ] `./validate.sh` → PASSED
- [ ] Client: title screen + world load — no crash
- [ ] Client: connect to local test server → no crash

---

### Phase 4 — Adventure & World (not yet started)

Exploration, structures, mobs. Full list in research files.
Install after Phase 3 is stable.

**Phase 4 gate — must pass before Phase 5:**

- [ ] `./validate.sh` → PASSED
- [ ] Client: title screen + world load — no crash
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
