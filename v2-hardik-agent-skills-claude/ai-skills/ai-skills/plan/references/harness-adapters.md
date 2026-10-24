# Harness Adapters

How to spawn sub-agents. The skill is harness-agnostic — adapt the pattern to what's available.

## Agent Output Contract (universal)

Every sub-agent receives:
```
Mission: <one-line goal>
Scope: <files/dirs to read>
Constraint: read-only — no source edits, no git mutations
Return format:
  Findings: <bullets>
  Implications: <bullets>
  Unknowns: <bullets>
```

Parent owns synthesis. Sub-agents never merge or resolve conflicts.

---

## OpenCode

Use native Plan + Explore agent types.

```
Plan (primary orchestrator)
 ├─ Explore → Structure agent
 ├─ Explore → Domain agent
 ├─ Explore → Contracts agent
 └─ Scout   → External deps (only if needed)
```

Keep research in Explore mode (read-only). Pass mission + scope + return format explicitly.
Avoid recursive delegation — keep depth flat.

---

## Claude Code

Use native Task/subagent facility.
Pass each task: mission, scope, read-only constraint, return format.
Run independent tasks in parallel where possible.

---

## Pi / Other Lightweight Models

Use for read-heavy, low-synthesis tasks (Structure agent, Domain agent).
Reserve parent model for synthesis and requirements.
Pass compressed context — these harnesses have smaller system prompt budgets.

---

## Fallback (no subagent facility)

Run roles sequentially in the same context:
1. Structure read
2. Domain read  
3. Contracts read

Synthesize after each. Less parallelism, same output contract.

---

## If Still Deciding

Default to sequential fallback. Swap to parallel agents when harness is confirmed.
The skill output (PLAN.md, memory files) is identical either way.
