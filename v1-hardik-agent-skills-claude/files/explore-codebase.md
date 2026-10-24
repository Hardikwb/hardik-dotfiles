---
name: explore-codebase
description: >
  Systematically map an unfamiliar or large codebase by spawning parallel read agents
  and returning a structured CONTEXT BLOCK. Use this skill whenever the user asks to
  "explore the codebase", "understand the project structure", "map the repo", 
  "what's in this codebase", or before planning a feature in a codebase that hasn't 
  been explored this session. Also trigger when the user says "I'm not sure where this 
  lives" or "can you look around first". 
  DO NOT trigger when the user references a specific known file, when the codebase was
  already explored earlier in this session, or for single-file reads.
---

# Codebase Explorer

Maps a codebase systematically using parallel read agents.
Returns a structured **CONTEXT BLOCK** for planning, analysis, or feature implementation.

**Job**: Observe and report. No recommendations. No code suggestions. No opinions.

---

## Steps

### 1 · Assess Scale

Read the top-level directory only. Count files and directories.

| Scale | Indicator | Strategy |
|-------|-----------|----------|
| **Small** | < 15 files total | Read directly — no sub-agents needed |
| **Medium** | 15–50 files | 2 agents: Structure + Domain |
| **Large** | 50–200 files | 3 agents: Structure + Data + Contracts |
| **Monorepo / XL** | 200+ files or multiple packages | 4 agents: Structure + Data + API + UI |

Identify the **feature area** if the user mentioned one — bias domain agents toward it.

---

### 2 · Assign Domain Agents

Spawn based on scale assessment. One agent = one domain, no overlap.

---

**Structure Agent** (always spawn)
```
Read:
  - Top-level directory listing
  - package.json / go.mod / pyproject.toml / Cargo.toml (whichever exists)
  - README.md or ARCHITECTURE.md if present
  - Any .env.example or docker-compose.yml

Return (bullets only):
  - Languages and frameworks in use
  - Entry points (main file, server bootstrap, CLI root)
  - Purpose of each top-level directory
  - Build / run commands
  - Monorepo layout if applicable
```

---

**Data Agent** (spawn for Large / XL)
```
Read:
  - Database models, ORM schemas, Prisma/SQLAlchemy/GORM definitions
  - Migration files (latest 2–3 to understand schema evolution)
  - Type definition files (types.ts, interfaces.go, models.py)

Return (bullets only):
  - Core entities and their relationships
  - ORM in use or raw SQL
  - Schema conventions (naming, indexing patterns)
  - Any soft deletes, audit fields, multi-tenancy patterns
```

---

**Contracts Agent** (spawn for Large / XL)
```
Read:
  - Route files, controllers, handlers
  - Middleware chain
  - Auth patterns (JWT, session, API key)
  - Any OpenAPI spec or tRPC router definitions

Return (bullets only):
  - Endpoint groups and their responsibilities
  - Request/response shape conventions
  - Auth enforcement pattern
  - External services called (Stripe, S3, email, etc.)
```

---

**UI Agent** (spawn for XL or when UI is in scope)
```
Read:
  - Pages or views directory
  - State management (Redux, Zustand, Pinia, Context)
  - Component library in use (shadcn, Ant, MUI, custom)
  - Router setup

Return (bullets only):
  - UI framework and version
  - Page/route structure
  - State management pattern
  - Component conventions (file naming, co-location)
```

---

### 3 · Compile CONTEXT BLOCK

Merge all agent outputs. Format:

```
## CODEBASE CONTEXT

Stack: [languages · frameworks · key libs]
Entry: [main file(s)]

Directories:
  /src/models    → ORM models and types
  /src/routes    → Express route handlers
  /src/services  → Business logic layer
  ...

Data layer:
  - ORM: Prisma 5.x
  - DB: PostgreSQL
  - Entities: User, Post, Comment (see /src/models/)

API layer:
  - REST with Express
  - Auth: JWT via Authorization header
  - Endpoints: /api/users, /api/posts ...

Patterns:
  - Repository pattern (services call repositories, not DB directly)
  - Dependency injection via constructor
  - Error handling: custom AppError class, central error middleware

Conventions:
  - Files: kebab-case
  - Types: PascalCase interfaces
  - DB columns: snake_case
  - API responses: { data, error, meta }

Constraints:
  - No breaking schema changes (migration required for any column change)
  - All endpoints require auth unless decorated @Public
  - Max response time 200ms for read endpoints

Hotspots:
  - src/middleware/auth.ts (touched by most features)
  - src/db/client.ts (Prisma singleton)
  - src/types/index.ts (shared types)
```

Return this CONTEXT BLOCK. Stop here — no further actions.

---

## Reference

### When to Expand Agent Coverage

- **Multiple languages in one repo** → add a language-specific agent for the non-primary language
- **Separate frontend/backend packages** → dedicated agents each
- **Microservices** → one agent per service *in scope for the feature*; skip unrelated services
- **Feature flagging system** → add a Flags Agent (reads flag definitions, rollout config)

### When to Reduce Agent Coverage

- User has already described the architecture in detail → skip to CONTEXT BLOCK compilation
- Codebase is mostly config / boilerplate (< 5 substantive source files) → single direct read
- User explicitly says "just look at [specific area]" → scoped single agent, not full exploration

### CONTEXT BLOCK Quality Rules

- Bullets and short phrases only — no prose, no paragraphs
- No file contents verbatim — summarize, don't copy
- No speculation about what the user wants to build
- No design suggestions or opinions
- No "I noticed that..." framing — just facts
- If two agents report conflicting information → flag it: `[Conflict: Agent A says X, Agent B says Y]`

### Freshness

This CONTEXT BLOCK is valid for the current session only.  
If the user makes significant changes to the codebase mid-session, re-run this skill or note which areas are stale.
