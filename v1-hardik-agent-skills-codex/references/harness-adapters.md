# Harness Adapter Guidance

The planning skills intentionally use the Agent Skills open format and do not hard-code a vendor-specific subagent API.

## General rule

When the current harness exposes a native subagent/Task mechanism:

1. create independent read-only tasks,
2. provide each task with an explicit mission and output contract,
3. run independent tasks in parallel,
4. wait for all required results,
5. synthesize in the parent context.

If no subagent facility exists, run the roles sequentially.

## OpenCode

OpenCode supports primary agents and subagents. Its built-in `Plan` agent is intended for analysis/planning, while `Explore` is read-only repository exploration and `Scout` is read-only external/dependency research in the current documented variants.

A planning setup can use:

```text
Plan (primary)
 ├─ Explore: architecture map
 ├─ Explore/General: execution trace
 ├─ Explore: test coverage
 └─ Scout: external dependency behavior (only if needed)
```

Keep planning research read-only. OpenCode also supports configurable subagent depth, so avoid unnecessary recursive delegation.

## Claude Code / other harnesses

Use the native subagent/task facility if available. Do not assume tool names inside the skill.

The important contract is behavioral, not vendor-specific:
- independent scopes,
- no shared edits,
- evidence-backed findings,
- parent synthesis.

## Lavish

Lavish is a visual artifact review tool, not the source of truth for requirements.

Use it when:
- a plan contains complex diagrams,
- comparing multiple designs would benefit from a visual artifact,
- the user wants interactive review controls.

Keep `PLAN.md` canonical.

## Chat-only fallback

When no structured UI exists, the skill uses one-at-a-time multiple-choice chat questions. This is intentionally close to the useful part of the `grill-me` interaction model without making another skill a hard dependency.
