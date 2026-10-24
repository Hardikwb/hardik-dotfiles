---
name: verify-requirements
description: Verify engineering requirements before implementation by inspecting the codebase first, then asking one high-leverage question at a time with concrete options, a recommended default, and explicit consequences until implementation-critical ambiguity is resolved.
---

# Verify Requirements

This skill is the human-alignment phase of planning.

Its purpose is to remove ambiguity without creating cognitive load.

## Core rule

**Never ask a question that the repository can answer.**

Read first. Ask second.

## Interaction style

Ask one question at a time.

Use:

```text
<question>

A. <concrete option>
B. <concrete option>
C. <concrete option>
D. Other

Recommendation: <A/B/C> — <brief reason>
Impact: <what changes depending on the answer>
```

For questions with no bounded choices, use a short free-form question and explain why it matters.

After the user answers:

```text
Recorded: <decision in one sentence>.
```

Then continue to the next unresolved decision.

## Decision ordering

Resolve in this order:

1. outcome/scope,
2. user-visible behavior,
3. compatibility constraints,
4. architecture boundaries,
5. data/state semantics,
6. failure/recovery behavior,
7. evaluation/acceptance,
8. rollout/migration.

Stop early when later questions are implementation details that the agent can choose safely.

## Strong question criteria

A question deserves to be asked only if a different answer would change one of:

- acceptance criteria,
- architecture,
- public interface,
- data model,
- security boundary,
- operational behavior,
- compatibility,
- implementation order.

## What not to do

Do not:
- dump a questionnaire,
- ask all possible edge cases up front,
- ask for a filename when the codebase determines it,
- use vague prompts like "Any other requirements?",
- repeatedly ask questions after the user has clearly closed the branch.

## Handling user uncertainty

If the user is unsure:
1. explain the concrete trade-off,
2. state the default you would choose for this repository,
3. ask for confirmation.

Do not pretend a subjective choice is a repository fact.

## Completion

Finish with:

```text
REQUIREMENTS VERIFIED

Goal:
...

Accepted behavior:
...

Important constraints:
...

Known non-goals:
...

Remaining unknowns:
<none or explicit list>
```
