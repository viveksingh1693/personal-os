# DATA_MODEL.md

> Defines the canonical domain model, entity relationships, ownership rules, identifiers, and lifecycle of data within Personal OS.

---

# 1. Purpose

The Data Model establishes a common vocabulary for the entire platform.

It is **not** a database schema.

Instead, it defines:

* Core business entities
* Relationships
* Ownership
* Aggregate boundaries
* Lifecycle
* Identity
* Versioning

Every module should reuse these entities where appropriate instead of creating duplicate concepts.

---

# 2. Design Principles

## Single Source of Truth

Every concept should have exactly one canonical representation.

Example:

There is only one **User** entity.

Finance, Health, and Calendar reference it.

---

## Domain Ownership

Each entity belongs to one module.

Other modules reference it through IDs or published events.

---

## Stable Identity

Every entity has a globally unique identifier that never changes.

---

## Event First

Changes are communicated using domain events.

Entities represent current state.

Events represent historical facts.

---

## Extensible

New modules should extend the model without modifying existing entities whenever possible.

---

# 3. Core Domain Model

```text
                           User
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
    Decision             Memory               Workflow
        │                    │                    │
        ├──────────┐         │         ┌──────────┤
        ▼          ▼         ▼         ▼
    Goal       Expense     Event     Notification
        │
        ▼
   Investment
```

---

# 4. Identity

All entities use globally unique identifiers.

Format

```text
usr_01...
exp_01...
mem_01...
evt_01...
dec_01...
wrk_01...
plg_01...
agt_01...
```

Identifiers never change.

They should not contain business meaning.

---

# 5. Core Entities

## User

Represents the owner of Personal OS.

Responsibilities

* Preferences
* Settings
* Identity
* Time zone
* Locale

The User entity owns no business logic.

---

## Event

Represents something that has already happened.

Examples

* Expense Created
* Plugin Installed
* Goal Completed

Events are immutable.

---

## Memory

Represents long-term knowledge.

Types

* Working
* Episodic
* Semantic
* Procedural
* Decision

Memory is managed only by the Memory Runtime.

---

## Decision

Represents an evaluated recommendation.

Contains

* Context
* Recommendation
* Confidence
* Reasoning
* Alternatives
* Outcome

---

## Goal

Represents a long-term objective.

Examples

* Buy House
* Emergency Fund
* Retirement
* Learn Kubernetes

Goals are measurable.

---

## Workflow

Represents an automation.

Examples

* Monthly report
* Daily reminder
* Receipt processing

---

## Plugin

Represents an integration.

Examples

* Telegram
* Gmail
* Browser

Plugins publish events.

---

## Agent

Represents an AI reasoning component.

Examples

* Planner
* Finance
* Health

Agents never own business data.

---

# 6. Finance Entities

Expense

Income

Budget

Account

Investment

Loan

Recurring Payment

Asset

Liability

Portfolio

All finance entities belong to the Finance module.

---

# 7. Health Entities

Workout

Meal

Sleep Session

Medication

Health Goal

Body Measurement

Owned by the Health module.

---

# 8. Knowledge Entities

Document

Note

Bookmark

Article

Research

Tag

Knowledge entities are searchable and link to Memory.

---

# 9. Relationships

```text
User
 │
 ├── Goals
 ├── Decisions
 ├── Memories
 ├── Expenses
 ├── Investments
 ├── Workflows
 └── Notifications
```

Modules should communicate via IDs and events rather than object references.

---

# 10. Aggregate Boundaries

Each aggregate owns its consistency.

Examples

Finance Aggregate

* Expense
* Budget
* Investment

Health Aggregate

* Workout
* Sleep
* Meal

Memory Aggregate

* Memory
* Embedding
* Consolidation

Cross-aggregate updates occur through events.

---

# 11. Ownership Rules

| Entity   | Owner            |
| -------- | ---------------- |
| User     | Core             |
| Event    | Event Runtime    |
| Memory   | Memory Runtime   |
| Decision | Decision Engine  |
| Goal     | Goals Module     |
| Expense  | Finance Module   |
| Workout  | Health Module    |
| Plugin   | Plugin Runtime   |
| Agent    | Agent Runtime    |
| Workflow | Workflow Runtime |

No module may modify another module's owned entities directly.

---

# 12. Lifecycle

Example: Expense

```text
Created

↓

Validated

↓

Stored

↓

Published

↓

Indexed

↓

Archived
```

Each entity defines its own lifecycle while following the same state transition principles.

---

# 13. Versioning

Every entity includes:

* id
* version
* createdAt
* updatedAt

Breaking schema changes require a new version.

---

# 14. Search

Structured search

* PostgreSQL

Semantic search

* Vector database

Hybrid search

* Combine structured filters with semantic similarity.

---

# 15. Auditability

Every important entity should answer:

* Who created it?
* When?
* What changed?
* Why?
* Which event caused the change?

Audit history is append-only.

---

# 16. Privacy

Every entity follows these rules:

* User owns the data.
* Export is supported.
* Deletion is supported.
* Encryption is supported where appropriate.
* Access is permission-based.

---

# 17. Future Extensions

Future entities may include:

* Vehicle
* Property
* Insurance
* Subscription
* Habit
* Relationship
* Skill
* Project
* Travel Plan
* Smart Device

These should integrate without requiring changes to existing entities.

---

# 18. Guiding Principle

> **The Data Model is the shared language of Personal OS. Modules own data, events describe change, memory preserves knowledge, and the Decision Engine reasons over them without violating ownership boundaries.**
