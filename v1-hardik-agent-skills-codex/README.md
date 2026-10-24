# Hardik Agent Skills — Planning System

A portable planning and requirements workflow for Agent-Skills-compatible coding harnesses.

## What this package is

This package is designed around the workflow shown in the supplied notes:

**Trigger → Context → Research → Requirements → Steering → Plan → Review → Execution handoff**

It deliberately does not depend on one harness. It can run in Claude Code, OpenCode, Codex, or another Agent Skills-compatible client.

The core skills are:

- `plan` — the main planning orchestrator.
- `codebase-research` — read-only repository reconnaissance and evidence gathering.
- `verify-requirements` — one-question-at-a-time requirement interrogation.
- `plan-review` — adversarial review of a completed plan.

The skills are designed to work together, but each can also be used independently.

## Philosophy

1. **Read before asking.** If the repository can answer a question, inspect it instead of asking the user.
2. **Ask one high-leverage question at a time.** Every question has a reason and, where useful, concrete options.
3. **Parallelize independent research.** Use native subagents when the harness provides them; otherwise perform the same roles sequentially.
4. **Subagents are read-only during planning.** Their job is to discover facts, not mutate the working tree.
5. **The parent agent owns synthesis.** Research agents return evidence; the main agent decides how the evidence affects the plan.
6. **Plans use vertical slices where practical.** Each slice should produce a testable increment rather than a layer-only checklist.
7. **No plan is considered closed until risks, tests/evals, operational concerns, and unresolved decisions are explicit.**
8. **Use visual review when it genuinely improves understanding.** Lavish is optional, not a dependency.

## Suggested workflow

```text
User request
    ↓
/plan
    ↓
Codebase reconnaissance (parallel when useful)
    ↓
Requirements interview (only unresolved questions)
    ↓
Draft plan + alternatives + open decisions
    ↓
/plan-review (parallel reviewers when useful)
    ↓
Final PLAN.md
    ↓
Execution handoff
```

## Install

Agent Skills are directories containing `SKILL.md`. The open specification requires `name` and `description` frontmatter and supports optional `references/`, `scripts/`, and `assets/` directories.

For OpenCode, copy the skill directories into `.agents/skills/` (project-local) or `~/.agents/skills/` (global), which OpenCode can discover. For Claude Code, use `.claude/skills/`. Other harnesses may expose their own compatible skills directory.

Example project-local layout:

```text
your-repo/
├── .agents/
│   └── skills/
│       ├── plan/
│       ├── codebase-research/
│       ├── verify-requirements/
│       └── plan-review/
└── ...
```

## Optional Lavish integration

Lavish Editor is useful for reviewing visual plans and interactive artifacts. The package does **not** require Lavish to function.

When a plan is large or visual, the `plan` skill may offer:

```text
npx -y lavish-axi
```

and may create an HTML plan artifact for browser-based review. The normal chat flow remains the fallback.

Lavish is especially useful for:
- architecture/flow diagrams,
- large plan comparisons,
- visual implementation maps,
- structured review forms.

It should not be treated as the question engine itself. The skill keeps the planning logic harness-agnostic and uses native chat/options first.

## Relationship to Matt Pocock skills

This package borrows the useful principles behind `grill-me`: ask one question at a time, walk unresolved branches, and inspect the codebase when it can answer the question.

It intentionally does not make `grill-me` a hard dependency. This keeps the workflow portable and lets `plan` add repository reconnaissance, parallel research, plan-review, and execution handoff around that interview pattern.

## Output convention

By default, `plan` creates a small plan bundle:

```text
<planning-root>/<slug>/
├── PLAN.md
├── RESEARCH.md
├── DECISIONS.md
└── OPEN-QUESTIONS.md
```

The planning root is selected from an existing repository convention if one exists. Otherwise, ask the user before creating a new durable planning directory, unless the harness already has a standard plan location.

