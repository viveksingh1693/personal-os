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
