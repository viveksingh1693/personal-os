# DECISION_ENGINE.md

> Defines the architecture, reasoning framework, decision lifecycle, and explainability model for Personal OS.

---

# 1. Purpose# IMPLEMENTATION_GUIDE.md

> Defines implementation standards, development workflow, coding conventions, project structure, and contribution guidelines for Personal OS.

---

# 1. Purpose

This document describes **how Personal OS should be implemented**.

It complements:

* `PROJECT.md` — Vision and philosophy
* `ARCHITECTURE.md` — System architecture
* `MODULE_SDK.md` — Business module contract
* `PLUGIN_SDK.md` — Integration contract
* `AGENTS.md` — AI runtime
* `EVENT_MODEL.md` — Communication contract

When implementation decisions conflict with architecture, the architecture documents take precedence.

---

# 2. Development Philosophy

Personal OS is developed using four principles:

* Build small, extensible components.
* Prefer composition over inheritance.
* Design for change.
* Optimize for maintainability over cleverness.

Every pull request should improve the architecture—not just add functionality.

---

# 3. Development Strategy

## Phase 1

Build a **Modular Monolith**.

Why?

* Faster iteration
* Easier debugging
* Simpler deployment
* Lower operational overhead
* Easier onboarding

Later, modules can be extracted into independent services without changing their contracts.

---

# 4. Technology Stack

## Backend

* FastAPI
* Python 3.12+

## Database

* PostgreSQL

## Cache

* Redis

## Event Bus

* Redis Streams

Later:

* Kafka

## AI

Primary

* Ollama

Optional

* OpenAI
* Anthropic
* Gemini

## Mobile

Flutter

## Automation

n8n

## Containers

Docker Compose

Future

Kubernetes

---

# 5. Repository Layout

```text
personal-os/

apps/
backend/
agents/
modules/
plugins/
sdk/
workflows/
infrastructure/
docs/
scripts/
tests/
```

Every directory has one responsibility.

---

# 6. Coding Standards

## General

* Small functions
* Explicit naming
* Avoid deep inheritance
* Prefer interfaces
* Avoid circular dependencies

---

## Naming

Classes

```text
ExpenseService
```

Interfaces

```text
ExpenseRepository
```

Events

```text
finance.expense.created
```

Agents

```text
FinanceAgent
```

Plugins

```text
TelegramPlugin
```

Modules

```text
FinanceModule
```

---

# 7. Dependency Rules

Allowed

```text
Module

↓

SDK

↓

Shared Utilities
```

Not Allowed

```text
Finance Module

↓

Health Repository
```

Cross-module communication must use events or public APIs.

---

# 8. Folder Convention

Example

```text
finance/

api/
application/
domain/
events/
prompts/
repository/
tests/
workflows/
```

Every module follows this structure.

---

# 9. Error Handling

Never swallow exceptions.

Every error should be:

* Logged
* Categorized
* Recoverable where appropriate

Business errors should be distinguishable from infrastructure failures.

---

# 10. Logging

Use structured logging.

Every log should include:

* Correlation ID
* User ID (when appropriate)
* Module
* Workflow
* Event ID

Never log secrets or sensitive personal data.

---

# 11. Testing Strategy

Required

* Unit Tests
* Integration Tests
* Event Tests
* API Tests

Recommended

* End-to-end Tests
* Performance Tests

Every bug should result in a regression test.

---

# 12. Git Strategy

Main branches

```text
main
develop
```

Feature branches

```text
feature/finance

feature/telegram-plugin

feature/planner-agent
```

Commit messages

```text
feat:

fix:

docs:

refactor:

test:

chore:
```

Follow conventional commits.

---

# 13. AI Development Guidelines

AI assistants should:

* Read `PROJECT.md` first.
* Respect module boundaries.
* Never duplicate business logic.
* Prefer existing abstractions.
* Update documentation when adding new features.
* Generate tests with implementation.

AI should assist implementation—not redefine architecture.

---

# 14. Pull Request Checklist

Before merging:

* Architecture respected
* Tests passing
* Documentation updated
* Events documented
* APIs documented
* No secrets committed
* Linting passes

---

# 15. Local Development

Start services

```text
docker compose up
```

Expected services

* PostgreSQL
* Redis
* Ollama
* n8n
* API
* Mobile (local emulator)

The project should be runnable with minimal setup.

---

# 16. CI/CD

Pipeline stages

1. Lint
2. Unit Tests
3. Integration Tests
4. Build
5. Security Scan
6. Package
7. Deploy (future)

No code should be merged without passing CI.

---

# 17. Documentation Rule

Every feature requires:

* Code
* Tests
* Documentation
* Events (if applicable)
* API updates (if applicable)

Documentation is part of the feature—not an afterthought.

---

# 18. Architectural Guardrails

Never:

* Allow plugins to contain business logic.
* Allow agents to write directly to databases.
* Allow modules to modify another module's data.
* Bypass the Event Bus for cross-module communication.
* Store long-term state inside agents.

These rules preserve long-term maintainability.

---

# 19. Definition of Done

A task is complete when it includes:

* Working implementation
* Automated tests
* Documentation updates
* Event definitions
* Logging
* Error handling
* Code review readiness

---

# 20. Guiding Principle

> **Build the platform so that adding the next feature is easier than adding the previous one. Every implementation decision should increase extensibility, maintainability, and clarity.**
# IMPLEMENTATION_GUIDE.md

> Defines implementation standards, development workflow, coding conventions, project structure, and contribution guidelines for Personal OS.

---

# 1. Purpose

This document describes **how Personal OS should be implemented**.

It complements:

* `PROJECT.md` — Vision and philosophy
* `ARCHITECTURE.md` — System architecture
* `MODULE_SDK.md` — Business module contract
* `PLUGIN_SDK.md` — Integration contract
* `AGENTS.md` — AI runtime
* `EVENT_MODEL.md` — Communication contract

When implementation decisions conflict with architecture, the architecture documents take precedence.

---

# 2. Development Philosophy

Personal OS is developed using four principles:

* Build small, extensible components.
* Prefer composition over inheritance.
* Design for change.
* Optimize for maintainability over cleverness.

Every pull request should improve the architecture—not just add functionality.

---

# 3. Development Strategy

## Phase 1

Build a **Modular Monolith**.

Why?

* Faster iteration
* Easier debugging
* Simpler deployment
* Lower operational overhead
* Easier onboarding

Later, modules can be extracted into independent services without changing their contracts.

---

# 4. Technology Stack

## Backend

* FastAPI
* Python 3.12+

## Database

* PostgreSQL

## Cache

* Redis

## Event Bus

* Redis Streams

Later:

* Kafka

## AI

Primary

* Ollama

Optional

* OpenAI
* Anthropic
* Gemini

## Mobile

Flutter

## Automation

n8n

## Containers

Docker Compose

Future

Kubernetes

---

# 5. Repository Layout

```text
personal-os/

apps/
backend/
agents/
modules/
plugins/
sdk/
workflows/
infrastructure/
docs/
scripts/
tests/
```

Every directory has one responsibility.

---

# 6. Coding Standards

## General

* Small functions
* Explicit naming
* Avoid deep inheritance
* Prefer interfaces
* Avoid circular dependencies

---

## Naming

Classes

```text
ExpenseService
```

Interfaces

```text
ExpenseRepository
```

Events

```text
finance.expense.created
```

Agents

```text
FinanceAgent
```

Plugins

```text
TelegramPlugin
```

Modules

```text
FinanceModule
```

---

# 7. Dependency Rules

Allowed

```text
Module

↓

SDK

↓

Shared Utilities
```

Not Allowed

```text
Finance Module

↓

Health Repository
```

Cross-module communication must use events or public APIs.

---

# 8. Folder Convention

Example

```text
finance/

api/
application/
domain/
events/
prompts/
repository/
tests/
workflows/
```

Every module follows this structure.

---

# 9. Error Handling

Never swallow exceptions.

Every error should be:

* Logged
* Categorized
* Recoverable where appropriate

Business errors should be distinguishable from infrastructure failures.

---

# 10. Logging

Use structured logging.

Every log should include:

* Correlation ID
* User ID (when appropriate)
* Module
* Workflow
* Event ID

Never log secrets or sensitive personal data.

---

# 11. Testing Strategy

Required

* Unit Tests
* Integration Tests
* Event Tests
* API Tests

Recommended

* End-to-end Tests
* Performance Tests

Every bug should result in a regression test.

---

# 12. Git Strategy

Main branches

```text
main
develop
```

Feature branches

```text
feature/finance

feature/telegram-plugin

feature/planner-agent
```

Commit messages

```text
feat:

fix:

docs:

refactor:

test:

chore:
```

Follow conventional commits.

---

# 13. AI Development Guidelines

AI assistants should:

* Read `PROJECT.md` first.
* Respect module boundaries.
* Never duplicate business logic.
* Prefer existing abstractions.
* Update documentation when adding new features.
* Generate tests with implementation.

AI should assist implementation—not redefine architecture.

---

# 14. Pull Request Checklist

Before merging:

* Architecture respected
* Tests passing
* Documentation updated
* Events documented
* APIs documented
* No secrets committed
* Linting passes

---

# 15. Local Development

Start services

```text
docker compose up
```

Expected services

* PostgreSQL
* Redis
* Ollama
* n8n
* API
* Mobile (local emulator)

The project should be runnable with minimal setup.

---

# 16. CI/CD

Pipeline stages

1. Lint
2. Unit Tests
3. Integration Tests
4. Build
5. Security Scan
6. Package
7. Deploy (future)

No code should be merged without passing CI.

---

# 17. Documentation Rule

Every feature requires:

* Code
* Tests
* Documentation
* Events (if applicable)
* API updates (if applicable)

Documentation is part of the feature—not an afterthought.

---

# 18. Architectural Guardrails

Never:

* Allow plugins to contain business logic.
* Allow agents to write directly to databases.
* Allow modules to modify another module's data.
* Bypass the Event Bus for cross-module communication.
* Store long-term state inside agents.

These rules preserve long-term maintainability.

---

# 19. Definition of Done

A task is complete when it includes:

* Working implementation
* Automated tests
* Documentation updates
* Event definitions
* Logging
* Error handling
* Code review readiness

---

# 20. Guiding Principle

> **Build the platform so that adding the next feature is easier than adding the previous one. Every implementation decision should increase extensibility, maintainability, and clarity.**


The Decision Engine is the core intelligence layer of Personal OS.

Its purpose is not to answer questions.

Its purpose is to help users make **better decisions** using:

* Long-term memory
* Current context
* Business rules
* AI reasoning
* External information
* User preferences

Every recommendation should be:

* Explainable
* Reproducible
* Auditable
* Context-aware

---

# 2. What is a Decision?

A decision is a recommendation produced after evaluating multiple sources of evidence.

Examples:

Financial

* Buy a car
* Purchase a house
* Invest bonus
* Increase SIP

Career

* Switch jobs
* Accept an offer
* Learn a new technology

Health

* Reduce weight
* Improve sleep
* Start a workout plan

Lifestyle

* Plan vacation
* Buy a laptop
* Cancel subscriptions

---

# 3. Decision Architecture

```text
                    User Request
                         │
                         ▼
                  Planner Agent
                         │
                         ▼
               Decision Orchestrator
                         │
      ┌──────────────────┼──────────────────┐
      ▼                  ▼                  ▼
  Memory Runtime     Domain Agents     External Tools
      │                  │                  │
      └──────────────────┼──────────────────┘
                         ▼
                 Context Builder
                         │
                         ▼
                 Rule Evaluation
                         │
                         ▼
                  AI Reasoning
                         │
                         ▼
                Decision Composer
                         │
                         ▼
                 Decision Response
                         │
                         ▼
                Decision Memory Store
```

---

# 4. Decision Lifecycle

Every decision follows the same lifecycle.

```text
User Intent

↓

Collect Context

↓

Retrieve Memories

↓

Execute Tools

↓

Evaluate Rules

↓

AI Reasoning

↓

Generate Recommendation

↓

Explain Recommendation

↓

Store Decision

↓

Learn From Outcome
```

---

# 5. Decision Inputs

A decision may use:

## User Context

* Current request
* Goals
* Preferences
* Constraints

---

## Long-Term Memory

* Previous decisions
* Habits
* Financial history
* Health history

---

## Domain Modules

Finance

Health

Goals

Shopping

Calendar

Knowledge

---

## External Sources

Search

Weather

Maps

Market Data

Calendar

Email

Documents

---

## Rules

Business rules

Personal rules

Compliance rules

Safety rules

---

# 6. Context Builder

The Context Builder is responsible for assembling only the information required for the current decision.

Example

User asks:

> Should I buy a Fronx?

Relevant context

✓ Income

✓ Savings

✓ Emergency Fund

✓ Existing Car

✓ Monthly Expenses

✓ Investment Goals

Ignored

✗ Workout history

✗ Browser bookmarks

✗ Movie preferences

Context should be minimal but sufficient.

---

# 7. Rule Engine

Rules are deterministic.

Examples

```text
Emergency Fund < 6 months

↓

High Risk
```

```text
Debt Ratio > 40%

↓

Avoid New Loan
```

Rules execute before AI reasoning.

LLMs should not replace deterministic calculations.

---

# 8. AI Reasoning

After rules complete, the AI evaluates:

Trade-offs

Risks

Benefits

Alternatives

Long-term consequences

AI should never ignore rule violations.

---

# 9. Decision Output

Every decision returns a structured response.

```json
{
  "decisionId": "dec_001",
  "status": "recommended",
  "confidence": 0.89,
  "summary": "...",
  "recommendation": "...",
  "reasoning": [],
  "assumptions": [],
  "alternatives": [],
  "risks": [],
  "nextActions": []
}
```

---

# 10. Explainability

Every recommendation must answer:

Why?

Why not?

What assumptions?

What evidence?

What memories?

What rules?

Example

Recommendation

Buy Fronx Delta

Evidence

* Fits budget
* Emergency fund maintained
* Lowest ownership cost

Alternatives

* Delay purchase
* Buy used

---

# 11. Confidence

Confidence is calculated using:

* Data completeness
* Rule certainty
* Memory quality
* AI confidence
* External data reliability

Low confidence recommendations should encourage users to gather more information.

---

# 12. Decision Memory

Every important decision is stored.

Example

```json
{
  "decision": "Bought Fronx",
  "reason": "...",
  "confidence": 0.91,
  "alternatives": [
    "Toyota Urban Cruiser"
  ],
  "outcome": "Pending"
}
```

Months later

Outcome

Satisfied

↓

Future recommendations improve.

---

# 13. Feedback Loop

The engine continuously learns.

```text
Decision

↓

User Action

↓

Outcome

↓

Feedback

↓

Memory Updated

↓

Future Decisions Improve
```

Learning is based on user outcomes, not blind reinforcement.

---

# 14. Decision Categories

Financial

Career

Health

Education

Travel

Shopping

Relationships

Time Management

Knowledge

Life Planning

Each category may define its own rules and scoring.

---

# 15. Safety

The Decision Engine should:

* Highlight uncertainty.
* Distinguish facts from inferences.
* Avoid presenting speculation as certainty.
* Encourage professional advice for medical, legal, or financial matters when appropriate.

Recommendations support the user—they do not replace expert judgment.

---

# 16. Extensibility

New decision domains should require:

1. A new module (if needed).
2. Domain-specific rules.
3. One or more specialized agents.
4. Optional plugins.
5. Registration with the Planner Agent.

Existing domains should not require modification.

---

# 17. Example Flow

User

> Should I buy this house?

Decision Engine

↓

Retrieve Financial Memory

↓

Retrieve Goals

↓

Calculate Cash Flow

↓

Evaluate Loan Rules

↓

Search Market Data

↓

AI Comparison

↓

Generate Recommendation

↓

Store Decision

↓

Explain Reasoning

---

# 18. Future Enhancements

* Multi-objective optimization
* What-if scenario simulation
* Monte Carlo financial projections
* Goal conflict analysis
* Personal value weighting
* Collaborative decisions (family mode)
* Temporal reasoning ("If I wait 12 months...")

---

# 19. Success Metrics

The Decision Engine succeeds when it:

* Produces recommendations that are understandable.
* Cites the evidence behind every recommendation.
* Improves as more user context becomes available.
* Learns from outcomes without compromising user privacy.
* Allows new domains to be added without redesigning the core engine.

---

# 20. Guiding Principle

> **The Decision Engine exists to augment human judgment—not replace it.**

Every recommendation should combine deterministic rules, relevant memories, trusted data, and AI reasoning to help users make informed, transparent, and explainable decisions.
