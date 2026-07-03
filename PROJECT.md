# PROJECT.md

> **This document defines the vision, architecture, engineering principles, and development philosophy of Personal OS.**

If there is a conflict between implementation and this document, this document wins.

---

# 1. Mission

Personal OS is an open-source, AI-first Personal Operating System.

Its purpose is to help users make better decisions by combining information from multiple aspects of their lives into a unified intelligence layer.

Unlike traditional AI assistants, Personal OS is designed to reason over long-term context rather than individual conversations.

---

# 2. Vision

Imagine having an operating system that understands:

* Your finances
* Your calendar
* Your goals
* Your habits
* Your health
* Your documents
* Your purchases
* Your long-term decisions

Instead of simply answering questions, Personal OS should provide intelligent recommendations based on all available context.

Examples:

* Should I buy this car?
* Can I afford this vacation?
* Am I saving enough?
* What are my spending patterns?
* Which subscriptions should I cancel?
* Should I switch jobs?
* What should I focus on this week?

---

# 3. Design Philosophy

Personal OS is built around four core principles.

## Everything is a Plugin

External integrations are plugins.

Plugins only ingest and normalize data.

Plugins must never contain business logic.

Examples:

* Telegram
* WhatsApp *(where officially supported)*
* Gmail
* Calendar
* Browser Extension
* GitHub
* CSV Import
* PDF Import

---

## Everything is a Module

Business domains are isolated.

Examples:

* Finance
* Health
* Shopping
* Goals
* Knowledge
* Career
* Travel
* Journal

Each module owns:

* Models
* APIs
* Services
* Business Rules
* Events
* AI Prompts

Modules must not directly depend on one another.

Communication happens through events.

---

## Everything is an Event

The system is event-driven.

Example:

```text
Expense Created

↓

Budget Updated

↓

Analytics Updated

↓

Goal Progress Updated

↓

Memory Updated

↓

Notification Sent
```

Services communicate through events rather than direct service calls.

---

## Everything is an Agent

AI functionality is implemented using specialized agents.

Examples:

* Planner Agent
* Finance Agent
* Health Agent
* Memory Agent
* Research Agent
* Shopping Agent
* Notification Agent

The Planner Agent decides which agents to invoke.

---

# 4. Non-Goals

Personal OS is **not** intended to:

* Replace banking software
* Replace medical professionals
* Replace financial advisors
* Replace cloud storage
* Become another chatbot

The project focuses on decision support, organization, and contextual reasoning.

---

# 5. Architecture Principles

## Modular First

Prefer modular boundaries over tightly coupled services.

---

## Event Driven

All significant state changes should emit domain events.

---

## AI Native

AI is a first-class capability, not an afterthought.

---

## Replaceable Components

Every infrastructure component should be replaceable.

Examples:

Database

```
Postgres

↓

MySQL

↓

SQLite
```

LLM

```
Ollama

↓

OpenAI

↓

Anthropic

↓

Gemini
```

Event Bus

```
Redis Streams

↓

Kafka

↓

RabbitMQ
```

Business logic should remain unchanged.

---

## Open by Default

The project should use open-source technologies whenever possible.

Cloud services should remain optional.

---

# 6. Technology Stack

Backend

* FastAPI

Database

* PostgreSQL

Caching

* Redis

Event Bus

* Redis Streams (initial)
* Kafka (future)

Vector Store

* Qdrant

Automation

* n8n

AI

* Ollama
* OpenAI (optional)

Client

* Flutter

Infrastructure

* Docker Compose

---

# 7. Repository Layout

```
apps/

backend/

agents/

modules/

plugins/

sdk/

infrastructure/

docs/

workflows/

tests/

scripts/
```

---

# 8. Coding Standards

## General

* Small functions
* Single responsibility
* Clear naming
* Avoid global state
* Prefer composition over inheritance

---

## API

REST first.

GraphQL may be introduced later.

---

## Database

* Explicit migrations
* No ORM magic
* Version-controlled schema

---

## AI

Prompts belong inside the owning module.

Never scatter prompts across the codebase.

---

## Events

Every event must:

* Have a version
* Have a timestamp
* Be immutable

---

# 9. AI Development Rules

AI-generated code must:

* Follow existing architecture
* Avoid duplication
* Be fully typed where applicable
* Include tests for business logic
* Never bypass module boundaries

AI should generate implementations—not architecture.

Architecture is a human decision.

---

# 10. Security

Security is mandatory.

Never:

* Store secrets in source control
* Commit API keys
* Store passwords in plaintext
* Log sensitive information

All credentials must come from environment variables or a secure secret manager.

---

# 11. Privacy

Personal OS processes highly personal data.

Privacy principles:

* User owns their data
* Local-first where possible
* Cloud is optional
* Transparent data flows
* Explicit user consent for integrations

---

# 12. Definition of Done

A feature is complete only if it includes:

* Implementation
* Tests
* Documentation
* Error handling
* Logging
* Event emission (where applicable)

---

# 13. Long-Term Vision

Personal OS should evolve into a platform rather than a single application.

Future capabilities include:

* Plugin Marketplace
* Agent Marketplace
* Workflow Marketplace
* Knowledge Graph
* Voice Assistant
* Smart Home Integration
* Wearable Device Integration
* Personal Decision Engine

---

# 14. Success Metrics

The project is successful if:

* New plugins can be added without modifying existing modules.
* New agents can be introduced without changing the orchestrator.
* Modules remain independent.
* Components are replaceable.
* The system remains understandable as it grows.
* AI accelerates development without compromising architecture.

---

# 15. Guiding Principle

> **Build a platform that helps people make better decisions—not just answer better questions.**
