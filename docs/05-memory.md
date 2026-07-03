# MEMORY.md

> Defines the Memory Runtime, memory hierarchy, storage architecture, lifecycle, retrieval strategy, and consolidation process for Personal OS.

---

# 1. Purpose

Memory is the long-term intelligence layer of Personal OS.

Without memory, the system is only a chatbot.

With memory, the system becomes a lifelong assistant capable of learning from experience.

Memory allows Personal OS to:

* Remember important information
* Learn user preferences
* Recall past decisions
* Identify long-term trends
* Personalize recommendations
* Build contextual understanding over time

Memory is **not conversation history**.

Conversation is only one source of memory.

---

# 2. Design Principles

The Memory Runtime follows these principles.

## Memory is Layered

Different types of information require different storage strategies.

---

## Memory is Selective

Not everything should be remembered.

Only information with long-term value should be retained.

---

## Memory is Searchable

Every memory should be retrievable through structured queries and semantic search.

---

## Memory Evolves

New information may strengthen, supersede, or invalidate existing memories.

---

## Memory is Explainable

Every recommendation should identify which memories influenced it.

---

# 3. Memory Architecture

```text id="q5q2aq"
                    Memory Runtime

                          │

        ┌─────────────────┼─────────────────┐

        ▼                 ▼                 ▼

 Working Memory     Long-Term Memory     Vector Index

        │                 │                 │

        └─────────────────┼─────────────────┘

                          ▼

                  Memory Retrieval API
```

---

# 4. Memory Types

Personal OS separates memory into five major categories.

---

## 4.1 Working Memory

Short-lived memory used during the current request.

Examples

* Current conversation
* Temporary calculations
* Active workflows
* Tool outputs

Lifetime

Minutes

Storage

In-memory cache

---

## 4.2 Episodic Memory

Represents experiences.

Examples

* Bought a car
* Started a new job
* Completed a marathon
* Took a vacation
* Moved to another city

Example

```text id="mj1k84"
July 2026

Purchased a Fronx

Reason

Needed reliable transportation
```

Lifetime

Years

Storage

PostgreSQL

---

## 4.3 Semantic Memory

Represents facts.

Examples

* Preferred investment strategy
* Favorite restaurants
* Monthly income range
* Dietary preferences
* Vehicle owned

Unlike episodic memory, semantic memory stores knowledge rather than events.

---

## 4.4 Procedural Memory

Represents routines.

Examples

* Morning workout
* Monthly investment process
* Daily expense logging
* Weekly review workflow

Procedural memory allows the system to automate recurring activities.

---

## 4.5 Decision Memory

This is the defining feature of Personal OS.

Every important decision is stored.

Example

```text id="hsiflp"
Decision

Buy Fronx

Date

2026-07-03

Reason

Affordable

Fuel efficient

Good resale

Alternative Considered

Toyota Urban Cruiser

Confidence

0.91
```

Future recommendations should reference previous decisions where relevant.

---

# 5. Memory Model

Every memory follows the same structure.

```json id="bjlcwy"
{
  "id": "mem_001",
  "type": "decision",
  "importance": 0.95,
  "createdAt": "...",
  "updatedAt": "...",
  "source": "finance",
  "summary": "...",
  "content": {},
  "embeddingId": "...",
  "tags": []
}
```

---

# 6. Memory Importance

Each memory receives an importance score.

Range

```text id="8fwz9w"
0.0

↓

1.0
```

Examples

0.95

Marriage

0.90

Bought House

0.85

Changed Job

0.60

Monthly Budget

0.20

Restaurant Visit

Importance affects retention and retrieval.

---

# 7. Memory Sources

Memory can originate from:

* Conversations
* Plugins
* Workflows
* User actions
* AI decisions
* External documents
* Calendar
* Emails
* Finance module
* Health module

---

# 8. Memory Storage

Structured

PostgreSQL

Semantic Search

Qdrant

Large Files

Object Storage

Cache

Redis

The storage backend should be replaceable.

---

# 9. Memory Retrieval

Memory retrieval combines:

* Structured queries
* Semantic similarity
* Importance
* Recency
* User context

Retrieval pipeline

```text id="ye30rr"
Query

↓

Relevant Modules

↓

Semantic Search

↓

Importance Ranking

↓

Context Assembly

↓

Planner Agent
```

---

# 10. Memory Consolidation

Over time, similar memories should be merged.

Example

Daily Expenses

↓

Monthly Spending Pattern

↓

Annual Spending Trend

Instead of remembering every coffee purchase forever, the system should derive meaningful habits.

---

# 11. Memory Expiration

Not all memories are permanent.

Examples

Temporary OTP

Expires immediately

Weather

24 hours

Meeting Reminder

After meeting

Workout Session

Retained as historical data

Decision

Permanent

Retention policies are configurable.

---

# 12. Forgetting

Users should be able to:

* Delete memories
* Correct memories
* Merge duplicates
* Mark memories as obsolete

Deleted memories should be removed from both structured storage and vector indexes.

---

# 13. Privacy

Users own their memory.

Principles

* Exportable
* Portable
* Deletable
* Transparent
* Local-first where practical

No memory should be shared externally without explicit consent.

---

# 14. Memory APIs

Core operations

* Store
* Retrieve
* Update
* Delete
* Search
* Consolidate
* Export

Modules interact with memory through APIs rather than direct database access.

---

# 15. Memory and Agents

Agents never own persistent memory.

Instead

Planner

↓

Memory Runtime

↓

Relevant Memories

↓

Agent

↓

Updated Memory

↓

Memory Runtime

This keeps agents stateless and interchangeable.

---

# 16. Decision Traceability

Every recommendation should answer:

* Which memories were used?
* Which facts influenced the result?
* What assumptions were made?

This makes AI recommendations explainable and auditable.

---

# 17. Future Enhancements

Planned capabilities include:

* Knowledge Graph
* Relationship Mapping
* Temporal Reasoning
* Memory Compression
* Automatic Summarization
* Cross-device Synchronization
* Memory Confidence Scores

---

# 18. Guiding Principle

> **Memory should preserve what matters, forget what doesn't, and always help explain why a recommendation was made.**

The Memory Runtime transforms Personal OS from a reactive assistant into a system that continuously learns, adapts, and reasons using long-term context.
