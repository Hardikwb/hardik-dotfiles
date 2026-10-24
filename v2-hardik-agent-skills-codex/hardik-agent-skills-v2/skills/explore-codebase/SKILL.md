---
name: explore-codebase
description: >
  Read-only, targeted exploration of an unfamiliar or incomplete codebase context. Use when
  planning needs facts that are not available in project memory or the current conversation.
  Explore only the relevant areas and optionally use a few parallel agents. Return structured
  findings; do not design the feature or modify code.
---

# Explore Codebase

Observe, map, and report. Do not implement.

1. Read `.ai/project-memory/README.md` when available.
2. Check whether memory already answers the question.
3. Inspect only the repository areas needed to close the context gap.
4. For medium/large gaps, use a small number of focused read-only agents.
5. Return structured findings with evidence paths.
6. Identify any stable knowledge worth adding to project memory.
7. Ask the user before persistent memory is changed.

See:
- `references/exploration.md`
- `references/agent-roles.md`
- `references/memory-output.md`
