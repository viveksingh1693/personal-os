# AI_DEVELOPMENT_GUIDE.md

> **Development rules for AI coding assistants contributing to Personal OS**

---

# Purpose

Personal OS is a long-term open-source platform.

The purpose of this document is to ensure that every AI coding assistant contributes consistently without introducing architectural drift, unnecessary complexity, or duplicated logic.

Every AI agent working on this repository should read this document before generating code.

---

# Development Philosophy

Personal OS is an **AI Operating System**, not a traditional CRUD application.

Every implementation should reinforce the following goals:

* Extensibility
* Maintainability
* Explainability
* Testability
* Modularity
* Long-term evolution

The objective is to make the next feature easier to build than the previous one.

---

# Required Reading Order

Before generating code, AI assistants should understand the architecture.

Read documents in the following order:

```text id="fy1q3u"
VISION.md

PROJECT.md

ARCHITECTURE.md

IMPLEMENTATION_GUIDE.md

DATA_MODEL.md

EVENT_MODEL.md

MODULE_SDK.md

PLUGIN_SDK.md

AGENTS.md

MEMORY.md

DECISION_ENGINE.md

WORKFLOW_ENGINE.md

API.md
```

Do not generate implementation code before understanding the architecture.

---

# Repository Principles

The repository follows these principles:

* Kernel-first architecture
* Component-based design
* Event-driven communication
* Capability discovery
* Hexagonal Architecture
* Domain-Driven Design
* AI-assisted development
* Modular implementation

The repository structure is considered frozen for version 1.0.

---

# AI Responsibilities

AI assistants should:

* Generate production-quality code
* Generate unit tests
* Generate integration tests
* Update documentation
* Suggest refactoring
* Detect architectural violations
* Follow repository conventions
* Prefer extension over modification

AI assistants should not:

* Redesign the architecture
* Introduce new top-level directories
* Duplicate business logic
* Bypass the Kernel
* Ignore dependency rules
* Hardcode infrastructure decisions

---

# Golden Rules

## Rule 1

Every executable unit is a Component.

Examples:

* Module
* Plugin
* Agent
* Workflow
* Tool

---

## Rule 2

Business logic belongs to Modules.

Never implement business rules inside:

* Plugins
* Agents
* Workflows
* Platform services

---

## Rule 3

Agents provide reasoning only.

They must not:

* Write directly to databases
* Implement business calculations
* Store long-term memory

---

## Rule 4

Plugins integrate external systems.

Plugins:

* Authenticate
* Read
* Normalize
* Publish events

Nothing more.

---

## Rule 5

Memory Runtime owns user memory.

Never store user memory elsewhere.

---

## Rule 6

Knowledge Runtime owns external knowledge.

Do not mix user memory with external documents.

---

## Rule 7

Components communicate through:

* Domain events
* Public APIs

Never access another component's persistence layer directly.

---

## Rule 8

Capabilities are discovered dynamically.

Never instantiate concrete implementations when a capability lookup is available.

---

## Rule 9

Platform services provide infrastructure.

Platform services never contain business logic.

---

## Rule 10

The Kernel owns lifecycle, discovery, orchestration, and dependency management.

Nothing bypasses the Kernel.

---

# Development Workflow

Every feature should follow this lifecycle:

```text id="bgljdr"
Specification

↓

Implementation

↓

Tests

↓

Documentation

↓

Review

↓

Merge
```

Do not skip documentation or testing.

---

# Module Development

Every module should contain:

```text id="vr0n6v"
README.md

SPECIFICATION.md

DATA_MODEL.md

EVENTS.md

API.md

WORKFLOWS.md

DECISIONS.md

TEST_PLAN.md
```

Implementation begins only after the specification is approved.

---

# Code Generation Guidelines

Generated code should be:

* Typed
* Async where appropriate
* Dependency injected
* Framework-independent in the domain layer
* Small and composable
* Readable

Avoid:

* God classes
* Deep inheritance
* Global state
* Circular dependencies
* Hidden side effects

---

# Documentation Rules

Every implementation must update documentation when it changes:

* APIs
* Events
* Data models
* Configuration
* Workflows
* Capabilities

Documentation is considered part of the implementation.

---

# Testing Standards

Every implementation should include:

* Unit tests
* Integration tests
* Event tests
* API tests (when applicable)

Where appropriate, also include:

* Contract tests
* Performance tests
* End-to-end tests

No production code should be generated without tests.

---

# Logging Standards

Use structured logging.

Every log entry should include:

* Correlation ID
* Request ID
* Component
* Capability
* Timestamp

Never log:

* Secrets
* Passwords
* Access tokens
* Sensitive user data

---

# Error Handling

Errors should be:

* Explicit
* Structured
* Recoverable where appropriate

Do not suppress exceptions.

Prefer domain-specific error types over generic exceptions.

---

# Security Guidelines

Always:

* Validate input
* Use least privilege
* Sanitize external data
* Respect permissions
* Keep secrets out of source code

Never:

* Hardcode credentials
* Assume trusted input
* Expose internal implementation details

---

# Architecture Validation Checklist

Before completing any implementation, verify:

* Does it respect module boundaries?
* Does it use the Kernel correctly?
* Does it publish required events?
* Does it avoid duplicate business logic?
* Does it follow the Component lifecycle?
* Does it update documentation?
* Does it include tests?

If any answer is "No", revise the implementation.

---

# Pull Request Expectations

Every pull request should contain:

* Production-ready code
* Automated tests
* Documentation updates
* Appropriate logging
* Error handling
* Type annotations
* Review-ready commits

---

# Commit Strategy

Prefer small, focused commits.

Examples:

```text id="nceig0"
feat(finance): add expense aggregate

feat(kernel): implement capability registry

fix(memory): prevent duplicate consolidation

docs(finance): update API specification

test(workflow): add retry integration tests
```

Follow Conventional Commits.

---

# Long-Term Evolution

New functionality should be added by:

* Creating new components
* Registering new capabilities
* Publishing new events
* Extending existing SDKs when necessary

Avoid modifying stable core abstractions unless justified by an Architecture Decision Record (ADR).

---

# Success Criteria

A contribution is successful when:

* It fits naturally into the existing architecture.
* It improves maintainability.
* It is independently testable.
* It is fully documented.
* It can be understood by another contributor without additional explanation.

---

# Guiding Statement

> **The role of an AI contributor is not to invent a new architecture—it is to strengthen the existing one. Every contribution should make the platform more modular, more maintainable, more testable, and easier for both humans and AI to extend in the future.**
