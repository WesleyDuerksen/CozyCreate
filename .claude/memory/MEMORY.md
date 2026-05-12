# Memory Index

- [Transportation philosophy](feedback_transportation.md) — No teleportation/non-Create travel mods; all transport must be built infrastructure
- [Homestead study — completion state](project_homestead_study.md) — All 5 phases complete, shortlist ready, next step is packwiz mod installation
- [Don't predict mod counts or scope outcomes](feedback_scope_judgments.md) — Evaluate candidates openly; don't anchor to a number before Phase 3 runs
- [Packwiz validation workflow and debugging](project_packwiz_validation.md) — How to run validate.sh, stale port fix, Steam 'n' Rails pin, Prism bootstrap debugging
- [Commit workflow — validate first, capture configs, check ignores](feedback_commit_workflow.md) — Required steps before every commit: validate.sh, git status server/config, update .gitignore and .packwizignore for any new dirs, verify index.toml
- [Config review must apply the design-rationale lens](feedback_config_review_lens.md) — read research/design-rationale files first, never accept defaults without reasoning
- [Verify mod installed before flagging a conflict](feedback_verify_installed_before_lens_call.md) — check /mods/ not just plan.md, which can be stale
- [Config review anchors](project_config_review_anchors.md) — load-bearing Create/CDG/Aeronautics/Power Grid settings that define the pack identity
- [Jetpacks accepted](project_jetpacks_accepted.md) — Create: Stuff 'n Additions jetpacks are kept at defaults; explicit exception to "Aeronautics only" rule, do not re-litigate
- [SP is build-only on superflat](project_sp_build_only.md) — SP exists for schematic prototyping; no exploration → server-only worldgen/QoL is fine
- [No pacman commands](feedback_no_pacman.md) — Don't run pacman search/install/query; suggest alternatives or have user install themselves
- [Don't lower default Xmx](feedback_dont_lower_xmx.md) — Don't reduce MaxMemAlloc/MinMemAlloc in export.sh; focus RAM optimization on on-heap and off-heap not the ceiling
