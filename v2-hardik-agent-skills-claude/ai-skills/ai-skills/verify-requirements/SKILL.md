---
name: verify-requirements
description: Clarify engineering requirements one question at a time before planning. Used internally by /plan. Can also be invoked standalone. Never asks what memory or the codebase already answers. Produces a REQUIREMENTS CLEAR summary.
---

# Verify Requirements

## Core Rule

Read memory and codebase first. Ask only what remains unresolved **and** would change the plan.

---

## Question Format

```
Question N:
<one question>

A. <option> — <consequence>
B. <option> — <consequence>
C. Other / I have a different requirement

Recommendation: A — <one-line reason>
Matters because: <what changes if answered differently>
```

After each answer:
```
Recorded: <decision in one sentence>.
```

---

## Priority Order

Ask in this order, stop when remaining unknowns are safe implementation details:

1. Scope + non-goals
2. User-visible behavior (success, failure, progress)
3. Compatibility constraints
4. Data + state semantics
5. Failure + recovery
6. Acceptance criteria
7. Rollout

Full category reference → `../plan/references/question-bank.md`

---

## Suppression Rules

Do not ask when:
- Memory or codebase already answers it
- The answer has no effect on plan architecture or acceptance criteria
- User already stated it clearly
- It's a low-impact detail the agent can choose safely

---

## Completion

```
REQUIREMENTS CLEAR

Goal: ...
Behavior: ...
Constraints: ...
Non-goals: ...
Open: <none or list>
```
