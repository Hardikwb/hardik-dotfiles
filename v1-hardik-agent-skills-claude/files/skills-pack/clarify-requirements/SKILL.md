---
name: clarify-requirements
description: >
  Deeply clarify requirements for a feature, task, or system design through structured
  questioning before any planning or implementation begins. Use this skill when the user's
  request is vague ("build me a dashboard", "add auth", "make it faster"), when a 
  requirement doc lacks technical specifics, when the user pastes a ticket with missing 
  context, or when they ask "what do I need to think about before building X?". 
  Also trigger when the user says "grill me", "ask me questions", "help me figure out 
  what I actually need", or "I'm not sure what I want yet".
  DO NOT trigger when requirements are already specific and actionable, or when the user 
  explicitly says "just build it" / "I know what I want, let's plan".
---

# Requirements Clarifier

Your job: surface the decisions the user hasn't made yet — before they cost time to undo.  
Do not plan. Do not suggest solutions. Ask questions only. Then wait.

## Steering

**Precise over broad** — "What happens when the payment fails after the order is created?" beats "What are the error cases?".  
**One category at a time** — Don't dump 15 questions at once. Group by theme. Present one group, get answers, then go deeper.  
**Options accelerate thinking** — For complex decisions, offer 2–3 options with a brief tradeoff. Don't make them invent from scratch.

---

## Steps

### 1 · Extract What's Known

Before asking anything, restate what you understand from the user's request:

```
Here's what I understand so far:
- You want to build: [capability]
- For: [who uses it]
- The core flow is: [A → B → C]
- Tech context: [stack / constraints mentioned]

Let me ask about the gaps that would change how we design this.
```

If your summary is wrong, the user corrects you — that's the first clarification.

---

### 2 · Ask by Category

Present one category at a time. 2–4 questions per category max.
After the user answers, optionally go deeper or move to the next category.

**Category order** (adjust based on what's actually unclear):

---

**A · Core Scope**
```
1. What does "done" look like for v1? What's the smallest version that ships?
2. What's explicitly out of scope for now? (name 2–3 things you're deferring)
3. Is this replacing something that exists, or net new?
```

---

**B · Users & Access**
```
1. Who uses this? (internal team / end users / both / API consumers)
2. Are there different roles with different permissions?
3. Does this need auth, or is it open/internal-only?
```

---

**C · Data & State**
```
1. What data does this feature create, read, update, or delete?
2. Is this data user-specific, shared across users, or global?
3. How long does data live? Any deletion or archival rules?
4. Consistency requirement: is it OK if data is slightly stale (eventual), 
   or must it always be current (strong)?
```

---

**D · Error & Edge Cases**
```
1. What's the most likely way this fails? What should the user see?
2. What happens if an external dependency (payment gateway, email, S3) is down?
3. Is there a retry strategy, or fail-and-notify?
```

---

**E · Scale & Performance**
```
1. Expected volume: requests/day, users, records?
2. Any latency requirement? (e.g. "must respond < 200ms")
3. Any known spikes (batch jobs, end-of-month, viral events)?
```

---

**F · Integration**
```
1. Does this connect to anything external? (third-party APIs, other services)
2. Does anything else depend on this? (other services that call it)
3. Any existing contracts that must be preserved?
```

---

### 3 · Offer Options for Hard Decisions

When a question has no obvious answer, present options:

```
For [DECISION], there are typically 3 approaches:

A) [Option] — Best when [context]. Tradeoff: [downside].
B) [Option] — Best when [context]. Tradeoff: [downside].
C) [Option] — Best when [context]. Tradeoff: [downside].

Which fits your situation? Or is there a constraint I'm missing?
```

---

### 4 · Compile Requirements Summary

After all categories are answered (or user says "enough, let's plan"):

```markdown
## Requirements: [Feature Name]

### What We're Building
[2–3 sentence plain-English description]

### Users
- Who: [roles / user types]
- Auth: [required / not required / which mechanism]

### Core Flows
1. [Happy path step by step]
2. [Secondary flow if any]

### Data
- Creates: [entity / fields]
- Reads: [what and how]
- Updates / Deletes: [rules]
- Retention: [how long]

### Error Handling
- [scenario] → [behavior]
- [scenario] → [behavior]

### Scale
- [volume / latency / spike info]

### Out of Scope
- [explicit deferrals]

### Open Decisions
- [anything still unresolved]
```

End with:
```
Requirements look complete. Want me to start planning the implementation now?
```

---

## Reference

### Signs You Need More Questions
- User used vague words: "fast", "simple", "secure", "scalable" — ask what those mean concretely
- User described the solution, not the problem — ask "what problem does that solve?"
- The feature touches money, auth, or personal data — always ask about error handling and edge cases

### Signs to Stop Asking
- Answers are getting repetitive or circular
- User says "figure it out" / "use your judgment" — respect that, document the assumption
- You have enough to write a plan that wouldn't change based on any remaining unknowns

### The "Options Accelerate Thinking" Rule
When the user is stuck on a decision, don't ask open-ended questions — offer structured choices.  
2–3 concrete options with clear tradeoffs are faster than "what do you want to do?"

### What NOT to Do
- Don't ask questions you can answer with reasonable defaults (use the default, note it in requirements)
- Don't ask about implementation details — save those for planning
- Don't repeat questions from a previous category in different words
- Don't ask more than 5 questions in a single message
