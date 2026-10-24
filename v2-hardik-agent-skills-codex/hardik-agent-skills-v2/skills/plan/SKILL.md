---
name: plan
description: >
  Plan a feature or system change before implementation. Start by understanding the user's intent,
  then retrieve project memory, explore only missing context, ask unresolved high-impact questions,
  define broad architecture and scale, and only then produce implementation plans. Use for
  non-trivial features, systems, refactors, architecture work, or requests to plan/build/design.
  Do not use for tiny edits or when the user explicitly wants immediate coding.
---

# Plan

Plan only. Do not write production code.

1. Understand the user's goal and desired workflow before proposing implementation.
2. Read `.ai/project-memory/README.md` first. Retrieve only memory relevant to the task.
3. Treat memory as cached project context, not truth. Verify only claims that are relevant and possibly stale.
4. If important context is missing, reference `explore-codebase` and use the smallest useful number of read-only agents.
5. If exploration discovers persistent project knowledge, propose a precise memory update. Ask the user before changing `.ai/project-memory/`.
6. Ask only questions that cannot be answered from the user, memory, or repository. Do not make assumptions unless the user explicitly allows them.
7. For complex work, determine the broad architecture first, including component boundaries, major flows, and rough scale implications. Then delegate focused planning work when useful.
8. Synthesize the findings into one architecture view and a small set of implementation plans. Prefer vertical implementation slices after architecture is clear.
9. Keep plans concise and reference-heavy. Do not copy repository details into the plan when a path/reference is enough.
10. Before implementation, show unresolved decisions and ask for confirmation.

See references only when needed:
- `references/planning.md`
- `references/complexity.md`
- `references/decomposition.md`
- `references/memory-protocol.md`
- `references/questions.md`
- `references/agent-delegation.md`

### Lavish / visual planning

Do not invoke Lavish by default. If the user asks for a visual plan, or explicitly names Lavish, use the available visualization/Lavish capability after the architecture is synthesized. The textual plan remains canonical.
