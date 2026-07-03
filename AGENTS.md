# AGENTS.md

> Defines the architecture, responsibilities, lifecycle, and interaction model for all AI agents within Personal OS.

---

# 1. Overview

Personal OS uses a **multi-agent architecture** instead of relying on a single, monolithic AI prompt.

Each agent is designed to solve one specific problem exceptionally well.

Agents collaborate through the **Planner Agent**, which coordinates execution and aggregates results.

```text
                    User
                      │
                      ▼
              Planner Agent
                      │
      ┌───────────────┼───────────────┐
      ▼               ▼               ▼
 Finance Agent   Health Agent   Research Agent
      │               │               │
      └───────────────┼───────────────┘
                      ▼
               Memory Agent
                      │
                      ▼
              Final Response
```

---

# 2. Design Principles

Every agent must follow these principles.

## Single Responsibility

An agent should solve **one domain**.

Examples:

✔ Finance Agent

✔ Health Agent

✔ Calendar Agent

❌ Personal Agent that does everything

---

## Stateless by Default

Agents should not maintain their own memory.

Persistent information belongs inside the Memory Runtime.

---

## Tool Driven

Agents never access databases directly.

Instead they use tools.

Examples:

* Expense Tool
* Calendar Tool
* Search Tool
* OCR Tool
* Email Tool

---

## Explainable

Agents must explain **why** they reached a recommendation.

---

## Deterministic When Possible

Business calculations should be deterministic.

LLMs should reason over facts—not invent them.

---

# 3. Agent Runtime

Every agent executes inside the Agent Runtime.

Lifecycle

```text
Receive Task

↓

Collect Context

↓

Select Tools

↓

Execute Tools

↓

Reason

↓

Produce Result

↓

Store Memory

↓

Return Response
```

---

# 4. Planner Agent

The Planner Agent is the brain of Personal OS.

Responsibilities

* Understand user intent
* Break work into tasks
* Choose agents
* Coordinate execution
* Merge results
* Produce final response

The Planner Agent should never contain domain knowledge.

It delegates domain reasoning.

---

# 5. Finance Agent

Responsibilities

* Expense analysis
* Budget analysis
* Savings recommendations
* Investment summaries
* Purchase affordability
* Financial forecasting

Tools

* Expense Tool
* Budget Tool
* Investment Tool
* Report Tool

Memory Used

* Financial Memory

---

# 6. Health Agent

Responsibilities

* Workout tracking
* Nutrition
* Sleep analysis
* Medication reminders
* Health insights

Memory

* Health Memory

---

# 7. Shopping Agent

Responsibilities

* Product comparison
* Price history
* Purchase recommendations
* Wishlist management

The Shopping Agent should consider financial context before recommending purchases.

---

# 8. Calendar Agent

Responsibilities

* Meeting summaries
* Scheduling
* Reminder generation
* Daily planning

Memory

* Calendar Memory

---

# 9. Research Agent

Responsibilities

* Web research
* Document analysis
* Summarization
* Knowledge extraction

External information should always be clearly distinguished from user-owned data.

---

# 10. Memory Agent

Responsibilities

* Retrieve relevant memories
* Rank memories by relevance
* Persist new memories
* Consolidate long-term memory
* Forget expired information according to retention rules

The Memory Agent never generates recommendations.

---

# 11. Notification Agent

Responsibilities

* Deliver notifications
* Generate reminders
* Send scheduled reports
* Alert users to significant events

Delivery channels may include:

* Push notifications
* Email
* Telegram
* WhatsApp *(where officially supported)*

---

# 12. Future Agents

Potential future agents include:

* Travel Agent
* Career Agent
* Learning Agent
* Relationship Agent
* Home Automation Agent
* Investment Agent
* Tax Agent

New agents should integrate without modifying existing agents.

---

# 13. Tool Access

Agents interact with the outside world through tools.

Examples

```text
Expense Tool

Calendar Tool

Email Tool

Search Tool

OCR Tool

Browser Tool

GitHub Tool

Weather Tool
```

Agents never call plugins directly.

---

# 14. Communication Model

Agents do not communicate directly.

All communication flows through the Planner Agent.

```text
Planner

↓

Finance

↓

Planner

↓

Memory

↓

Planner

↓

Health

↓

Planner
```

This keeps the system predictable and simplifies debugging.

---

# 15. Agent Context

Each execution receives:

* User request
* Relevant memories
* Tool outputs
* Active workflows
* Current timestamp
* System configuration

Agents should receive only the context necessary for the current task.

---

# 16. Agent Response Contract

Every agent returns a structured response.

```json
{
  "agent": "finance",
  "status": "success",
  "confidence": 0.93,
  "summary": "...",
  "reasoning": "...",
  "recommendations": [],
  "memory_updates": [],
  "events": []
}
```

This standard format allows the Planner Agent to combine results consistently.

---

# 17. Error Handling

Agents should fail gracefully.

Failures should include:

* Error category
* Recoverability
* Suggested fallback

Whenever possible, the Planner Agent should continue using partial results from other agents.

---

# 18. Security

Agents must:

* Respect user permissions
* Never expose secrets
* Avoid unnecessary data access
* Log actions without logging sensitive content
* Clearly identify when information comes from external sources

---

# 19. Extensibility

Adding a new agent should require:

1. Implementing the Agent interface.
2. Registering it with the Agent Registry.
3. Declaring supported capabilities.
4. Exposing any required tools.
5. Adding tests and documentation.

Existing agents should not require modification.

---

# 20. Guiding Principle

> **Agents should reason. Modules should own business logic. Plugins should ingest data. The Planner should orchestrate. Memory should preserve context.**
