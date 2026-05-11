---
name: Config review anchors — settings that MUST stay at specific values
description: Specific Create/CDG/Aeronautics/Power Grid settings that are load-bearing for the CozyCreate design philosophy and should not drift
type: project
originSessionId: d9fde917-300f-4c7a-bab0-5643a5249f85
---
These are the agency-preserving / engineering-depth knobs that define CozyCreate's identity. If a config update or auto-merge changes any of them, flag it.

**Why:** Each of these enforces a pillar of the pack design. Changing them silently shifts the pack toward kitchen-sink Create rather than curated cozy-engineering. Recorded after Tier 1 server config review on 2026-05-10.

**How to apply:** When reviewing any of these configs in future sessions, verify the values match before considering the file "reviewed." If a player or update flips one, surface it.

### `create-server.toml`
- `bulkPressing = false` — bulk processing trivializes "build more presses"
- `bulkCutting = false` — same
- `disableStress = false` — stress is the central engineering puzzle
- `fillInfinite = false` + `hosePulleyBlockThreshold = 10000` — the anti-trivialization knob for fluids
- `harvestPartiallyGrown = false` + `harvesterReplants = true` — forces good farm design
- `trainsCauseDamage = true` — authentic infrastructure consequence

### `powergrid-server.toml`
- `overheating = true` + `wireOverheating = true` + `explosiveDeconstruction = true` — these ARE the electrical engineering challenge
- `splittingTransmissionLines = false` + `splittingsTransformers = false` — experimental, stability-first

### `createdieselgenerators-server.toml`
- `Engines filled with a bucket = false` — forces pipe infrastructure for fuel logistics (transport-as-progression applied to fuel)
- `Engines disabled with redstone = true` — engineering control primitive
- `Combustibles blow up = true` — diesel should bite
- `Disable normal oil chunks = false` + `Disable high oil chunks = false` — both tiers required for diesel→electrical progression

### `aeronautics-server.toml`
- Lift caps (`hot_air_burner_max = 500`, `steam_vent_hot_air_amount = 5000`) — gate airship size; matches "earn your flight"

### Deferred to launch (not Phase 6)
- `powergrid-server.toml` `solverBackend` — switch JAVA→NATIVE for perf if host supports, after deploy target chosen
- `neruina.json5` `auto_kill_ticking_entities` — keep false during dev (errors visible), revisit at launch (auto-recovery friendlier for live MP)
- `structureessentials.json` `autoBiomeCompat.enableBiomeCompat` — keep false; revisit if modded biomes feel structure-starved at playtest

### Tier 2 anchors (added 2026-05-10)

**`railways-server.toml`** (Steam 'n' Rails)
- `realisticTrains = true` — trains require fuel from tanks/chests. Parallel logic with diesel engines needing fuel; makes rail logistics a real engineering concern
- `realisticFuelTanks = true` — only proper liquid fuels accepted
- `creeperTrackDamage = false` — protects rail investment
- `mustOwnBoundTrain = false` — collaborative train use on trusted MP

**`towns_and_towers/structure_rarity_new.json5`**
- `towers.separation = 24` and `towns.separation = 24` (NOT 12). Vanilla 24-chunk separation keeps each settlement a destination, supporting "transport is progression"

**`voicechat/voicechat-server.properties`**
- `allow_recording = false` — privacy default; record only with explicit opt-in
- `max_voice_distance = 48`, `whisper_distance = 24` — workshop scale, do not change
- `force_voice_chat = false` — vanilla clients welcome

**`corpse-server.toml`**
- `death_storage_duration = -1` (infinite), `force_time = -1` (never auto-despawn), `fall_into_void = false`, `lava_damage = false`, `only_owner = false` — all critical for "no punishing item loss" / collaborative recovery

**`lootr-common.toml`**
- `randomise_seed = true` — per-player loot, no race-to-loot
- `convert_mineshafts = true`, `convert_item_frames = true`, `convert_elytras_to_item_frames = true` — preserves end-city elytra awe

**`sereneseasons/`**
- `progress_season_while_offline = true` — essential for MP, do not disable
- `out_of_season_crop_behavior = 0` — grow slowly (NOT "can't grow"). Automation still works; growth lamps are the engineering response to winter

**`NoChatReports/NCR-Common.json`**
- `demandOnClient = false` — vanilla clients can still join. NCR is privacy-from-Mojang, NOT player policing
