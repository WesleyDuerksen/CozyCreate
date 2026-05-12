---
name: Don't lower default Xmx in export.sh
description: Don't reduce MaxMemAlloc/MinMemAlloc in scripts/export.sh as part of memory optimization
type: feedback
---

Do not reduce `MaxMemAlloc` or `MinMemAlloc` in `scripts/export.sh` without explicit user instruction, even when the heap dumps show the pack runs comfortably below the current limit.

**Why:** User rejected an edit dropping `MaxMemAlloc=12288 → 6144` during the 0.4.0 memory optimization pass. The default Prism Xmx is a separate decision from on-heap memory tuning — the user keeps headroom on purpose (modded MC heaps balloon with explored area, mob spawning, JEI search activity, etc.) and shipping a lower default could break the experience for users who explore widely.

**How to apply:** When asked to "reduce client RAM" or similar, focus on on-heap reductions (config flips, mod removals, lazy-loading mixins) and process-level off-heap costs (DH-style native buffers). Leave the JVM ceiling alone unless the user explicitly says "lower Xmx" or "drop the heap size."
