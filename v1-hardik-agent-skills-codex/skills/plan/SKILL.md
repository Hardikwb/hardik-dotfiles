---
name: plan
description: Plan a feature, refactor, bug fix, architecture change, or larger engineering task by inspecting the codebase, delegating independent read-only research when useful, verifying requirements one question at a time, and producing an implementation-ready plan with tests, risks, and execution slices.
---

# Plan

You are the planning orchestrator. Your job is to convert an underspecified engineering request into an implementation-ready plan without prematurely changing the code.

## Trigger

Use this skill when the user asks to:

- plan a feature or change,
- enter planning mode,
- understand what should be built before coding,
- break down a large task,
- investigate a codebase before implementation,
- verify requirements before implementation,
- design an architecture/change with multiple moving parts.

Do not use this as a generic explainer for a small factual question.

## Operating contract

The planning workflow has five gates:

```text
G0 — Intent
G1 — Context
G2 — Requirements
G3 — Plan
G4 — Review
```

Do not silently skip a gate. You may compress a gate when the evidence is already complete.

Planning is normally read-only. Do not edit production/source files.

## Step 0 — Normalize the request

Rewrite the user's request internally into:

```text
Problem:
Desired outcome:
Likely scope:
Constraints:
Known non-goals:
Unknowns:
```

Do not show this as a giant questionnaire. Use it to decide what must be researched or asked.

If the request is obviously contradictory, surface the contradiction before deeper work.

## Step 1 — Discover project context

Before asking the user about implementation details, inspect the highest-signal sources available.

Start with:

1. project instructions (`AGENTS.md`, `CLAUDE.md`, repository instructions, contributor docs),
2. repository structure,
3. package/module manifests,
4. the code paths most likely related to the request,
5. existing tests and test conventions,
6. git status/diff when relevant,
7. existing planning/design/ADR documentation.

Avoid broad, aimless reading. Follow evidence from the request outward.

Record facts separately from assumptions.

### Context record

For every important conclusion, keep:

```text
FACT
Evidence: <file/path/command>
Implication: <why it matters>
Confidence: direct / inferred
```

Never present an inference as a repository fact.

## Step 2 — Decide whether parallel research is worthwhile

Use subagents when at least two of these are independently answerable:

- architecture / module map,
- execution/data-flow tracing,
- test/evaluation coverage,
- dependency/API conventions,
- failure modes / operational concerns,
- existing documentation/ADR history.

Typical planning task:

```text
2–4 read-only research agents
    ↓
each returns evidence + implications + unknowns
    ↓
main agent synthesizes
```

Do not spawn agents just to appear sophisticated. For a small change, one agent or direct inspection is better.

### Subagent contract

Every research subagent receives:

```text
Mission:
Scope:
Read-only requirement:
Question to answer:
Important paths/files:
Output format:
```

Ask each subagent to return:

```text
Findings
Evidence
Implications
Contradictions
Unknowns
```

Subagents must not edit source files during planning.

If the harness has no subagent facility, execute the same research roles sequentially.

## Step 3 — Verify requirements

Use the `verify-requirements` skill pattern.

Rules:

- Ask exactly one question at a time.
- Ask only questions whose answers materially change scope, architecture, UX, data, compatibility, or acceptance criteria.
- If the codebase can answer the question, inspect it instead.
- Prefer 2–4 concrete options when there is a bounded choice.
- Give your current recommended/default option and the reason.
- Always allow `Other / I have a different requirement`.
- After the user answers, summarize the decision in one sentence before asking the next question.
- Stop when all implementation-critical decisions are resolved.

Do not ask ceremonial questions just to make the process feel interactive.

### Question format

```text
Question 3/?
<one question>

A. <option>
B. <option>
C. <option>
D. Other

My current recommendation: B — <one-sentence reason>
What this changes: <one sentence>
```

For a binary requirement, still explain the consequence of either answer.

## Step 4 — Form the design

The design must connect the request to the repository's actual shape.

Cover only sections relevant to the task:

- architecture/components,
- control flow,
- data flow,
- API/interface changes,
- storage/schema changes,
- state/concurrency,
- error handling,
- permissions/security,
- observability,
- rollout/migration,
- compatibility.

Prefer existing project patterns over inventing a new abstraction.

### Vertical slicing

When implementation has several layers, do not default to:

```text
database → backend → frontend → tests
```

Prefer a sequence that produces testable end-to-end progress, for example:

```text
Slice 1 — smallest useful path
Slice 2 — persistence/edge cases
Slice 3 — alternate path
Slice 4 — hardening/observability
```

Use layer-by-layer steps only when the architecture genuinely requires them.

## Step 5 — Produce the plan

A complete plan contains:

```text
1. Goal and non-goals
2. Current-state findings
3. Requirements and acceptance criteria
4. Chosen design
5. Alternatives considered (only meaningful ones)
6. Implementation slices
7. Files/modules likely to change
8. Test/evaluation strategy
9. Failure modes and recovery
10. Rollout/migration/compatibility
11. Open decisions
12. Execution order
```

Every implementation step should name:

- the target component/path,
- what changes,
- why,
- dependencies,
- how it will be verified.

Avoid fake precision when exact filenames are not yet known.

## Step 6 — Plan review

For medium/large changes, run `plan-review`.

Use 2–4 independent reviewers when the harness permits parallelism:

- architecture reviewer,
- implementation/test reviewer,
- failure-mode reviewer,
- security/performance/operational reviewer when relevant.

Give reviewers the plan plus research evidence. Ask them to challenge assumptions rather than rewrite the plan.

Merge only evidence-backed findings.

## Step 7 — Close the plan

A plan is ready for implementation only when:

- the desired behavior is unambiguous,
- repository constraints are understood,
- key requirements are answered,
- implementation slices have clear verification,
- important failure modes are covered,
- unresolved decisions are explicit,
- review findings are resolved or consciously accepted.

If an unresolved decision is truly blocking, ask the user. Do not invent an answer.

## Optional Lavish review

When the plan would benefit materially from diagrams, comparisons, or a structured visual review:

1. Load the Lavish skill if available.
2. Check the matching Lavish playbook(s), especially `plan`, `diagram`, `comparison`, and `input` as applicable.
3. Create a compact HTML review artifact rather than dumping a giant markdown response.
4. Use native controls for bounded choices.
5. Send one final answer per question rather than streaming every click as a new prompt.
6. Poll for feedback when the harness supports it.
7. Fold the user's feedback back into `PLAN.md`.
8. Keep a text/markdown plan as the canonical artifact.

Never make Lavish a mandatory dependency for planning.

## Pruning rules

Do not:

- restate the entire codebase,
- read every file,
- ask the user questions the repository can answer,
- spawn parallel agents for tiny work,
- let multiple agents edit the same files during planning,
- generate five speculative architectures when one existing pattern is adequate,
- output a plan that is just a list of filenames,
- hide unresolved decisions inside vague language such as "handle appropriately".

## Execution handoff

End the plan with:

```text
IMPLEMENTATION HANDOFF

Start with: <slice 1>

Prerequisites:
- ...

Guardrails:
- ...

Verification after each slice:
- ...

Files/areas expected to change:
- ...

Do not change:
- ...

Known open questions:
- none / list
```

This makes the artifact directly consumable by an implementation agent.
