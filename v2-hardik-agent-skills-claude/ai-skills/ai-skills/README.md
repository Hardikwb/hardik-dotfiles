# AI Skills — Planning System

Lightweight, portable planning workflow for Agent-Skills-compatible harnesses.

## Skills

| Skill | Invoke | Job |
|-------|--------|-----|
| `plan` | `/plan <description>` | Orchestrate: memory → research → requirements → PLAN.md |
| `explore` | `/explore` | Map codebase → write `.ai/project-memory/` |
| `update-memory` | `/update-memory` | Refresh stale memory files after code changes |
| `verify-requirements` | internal or `/verify` | One-question-at-a-time requirement clarification |

## Workflow

```
/plan <feature>
    ↓
Check .ai/project-memory/
    ├─ Missing → "Run /explore? Y/N"
    │               ↓ Y
    │            /explore → writes memory → resume /plan
    │
    └─ Exists → selective load (only relevant files)
                    ↓
               Research (only if memory insufficient)
               Spawn: Structure · Domain · Contracts agents
                    ↓
               /verify-requirements (one question at a time)
                    ↓
               Write PLAN.md → repo root
```

## Project Memory Structure

```
.ai/
├── skills/              ← skill files live here
│   ├── plan/
│   ├── explore/
│   ├── update-memory/
│   └── verify-requirements/
└── project-memory/      ← generated, gitignore or commit — your choice
    ├── overview.md
    ├── architecture.md
    ├── flows.md
    ├── components/
    │   └── <name>.md
    └── meta.md
```

## Install

Copy skill folders into your harness's skills directory:

- **Claude Code**: `.claude/skills/`
- **OpenCode**: `.agents/skills/`
- **Global**: `~/.claude/skills/` or `~/.agents/skills/`

## Design Principles

1. **Memory first** — read before asking, ask before assuming.
2. **Selective load** — never read all memory files; load only what the feature needs.
3. **Tests: path only** — note test folder location; never read test contents during planning.
4. **One question at a time** — options + default + consequence, then wait.
5. **Vertical slices** — each plan slice is a working end-to-end increment, not a layer.
6. **Harness-agnostic** — parallel agents when available; sequential fallback otherwise.
7. **Under 80 lines per SKILL.md** — detail lives in `references/`, loaded on demand.
