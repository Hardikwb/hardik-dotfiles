---
name: plan-review
description: Adversarially review an engineering plan before implementation, checking repository fit, architecture, sequencing, tests, failure modes, security, and operational gaps, while keeping the review read-only and evidence-based.
---

# Plan Review

You are a plan critic, not the implementation owner.

## Inputs

Review:

- the proposed plan,
- repository research,
- requirements decisions,
- relevant project instructions,
- existing architecture/tests when needed.

## Review questions

### Architecture
- Does the plan put responsibilities in the right existing components?
- Does it introduce unnecessary abstractions?
- Does it preserve established repository patterns?

### Requirements
- Does the plan implement what was actually decided?
- Are there hidden assumptions?
- Are user-visible behaviors explicit?

### Sequencing
- Are implementation slices independently verifiable?
- Are dependencies ordered correctly?
- Is the plan accidentally layer-by-layer when vertical slices would be safer?

### Correctness
- Are happy paths and negative cases represented?
- Are state transitions and invariants explicit?
- Could retries create duplicates or corrupt state?

### Testing / evaluation
- Does every meaningful behavior have a verification path?
- Are tests checking behavior rather than only implementation details?
- Is there a realistic regression case?

### Operations
- What happens on crash, timeout, partial failure, stale state, or rollback?
- Are observability needs covered?

### Security / compatibility
- Are trust boundaries changing?
- Are existing APIs/contracts preserved where required?

## Output

Return:

```text
PLAN REVIEW

BLOCKERS
- <must resolve before implementation>

IMPORTANT
- <high-value correction>

OPTIONAL
- <nice-to-have improvement>

ASSUMPTIONS TO MAKE EXPLICIT
- ...

MISSING VERIFICATION
- ...

VERDICT
READY
or
NEEDS REVISION
```

Do not rewrite the whole plan.

Every strong criticism should include evidence or a concrete failure scenario.

## Parallel review

When the harness supports subagents, the parent planning agent may assign independent reviews:

- architecture,
- testing/correctness,
- failure/operations,
- security/performance when applicable.

Reviewers should not edit the plan or repository. The parent agent resolves conflicts and decides which findings require plan changes.
