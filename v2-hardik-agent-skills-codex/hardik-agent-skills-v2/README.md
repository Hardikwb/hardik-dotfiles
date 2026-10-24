# Hardik Agent Skills v2

Small, reference-driven skills for a persistent AI engineering workflow.

## Skills

- `plan` — understand → retrieve memory → explore missing context → clarify → architecture → implementation plans.
- `explore-codebase` — read-only targeted repository exploration with optional parallel agents.
- `review` — review changed code and detect project-memory updates.

## Project memory

Put persistent project knowledge under `.ai/project-memory/`.

The memory is an indexable cache, not generated documentation. Read `README.md` first, then follow only relevant references.

## Harnesses

Harness-neutral by design. OpenCode and Pi are first-class targets, but the skills do not hard-code harness commands. The harness supplies subagent execution and interaction primitives.

## Visual planning

Lavish is optional. The planning workflow does not require it. Use a Lavish/visualization skill only when the user asks for a visual plan or the harness has an explicit visualization capability.
