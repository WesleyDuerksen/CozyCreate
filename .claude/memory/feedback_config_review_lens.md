---
name: Config review must apply the design-rationale lens
description: When reviewing modpack configs, always re-read research/design-rationale files first and analyze each setting against pack philosophy — don't just accept defaults
type: feedback
originSessionId: d9fde917-300f-4c7a-bab0-5643a5249f85
---
When working through `config-review.md` tiers (or any modpack config review), do NOT just skim configs and accept defaults with summary verdicts. The user pushed back when I marked Tier 1 "done" after a quick pass.

**Why:** CozyCreate's defaults often happen to align with the pack's philosophy, but accepting them without explicit reasoning misses (a) the cases where defaults conflict with design intent, and (b) the documentation value of recording *why* each setting was kept. Mod authors tune defaults for their own packs' philosophy, not ours.

**How to apply:**
1. **Before reviewing any tier**, read `docs/research/aeronautics-phase5-design-rationale.md` and `docs/research/homestead-phase5-design-rationale.md`. These articulate the agency-preservation, automation-as-infrastructure, no-shortcuts, trusted-MP, stability-over-content principles that drive every config call.
2. For each setting that has design implications (anything affecting balance, automation, transport, power, agency), explicitly state which design constraint the value upholds or violates. Settings that just happen to align should be flagged so as such — call out *what they preserve*, e.g. `bulkPressing=false` preserves the "build more presses" engineering decision.
3. Mechanical/perf settings (memory dedup, chunk save timing, mixin toggles) don't need the lens — say so and move on.
4. Record changes AND non-changes in `docs/config-review.md` with reasoning. The tracker is documentation of the design decision, not just a checkbox.
5. Trusted-MP shifts some defaults: lag/diagnostic notifications should usually go to OP, not all players (e.g. `leaky.json` chatnotification).
