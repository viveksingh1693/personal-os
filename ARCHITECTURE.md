# ARCHITECTURE.md

> **Personal OS Architecture**
>
> Version: 0.1 (Foundation)

---

# 1. Purpose

This document describes the architecture of Personal OS.

It defines:

* Major system components
* Responsibilities
* Boundaries
* Communication patterns
* Extensibility model
* Technology choices

This document intentionally focuses on architecture rather than implementation details.

---

# 2. Architectural Principles

Personal OS follows these architectural principles:

1. Modular Architecture
2. Event-Driven Communication
3. Plugin-Based Integrations
4. AI-Native Design
5. Domain-Driven Modules
6. Replaceable Infrastructure
7. Local-First, Cloud-Optional
8. Privacy by Design

---

# 3. System Overview

```text
                                      Clients
                     Flutter | Web | Desktop | CLI
                                              │
                                              ▼
                                    API Gateway / BFF
                                              │
                                              ▼
                                  Agent Orchestrator
                                              │
          ┌───────────────────────────────────┼────────────────────────────────────┐
          │                                   │                                    │
          ▼                                   ▼                                    ▼
   Plugin Runtime                     Module Runtime                       Agent Runtime
          │                                   │                                    │
          └───────────────────────────────────┼────────────────────────────────────┘
                                              │
                                              ▼
                                        Event Bus
                                              │
           ┌──────────────────────────────────┼──────────────────────────────────┐
           ▼                                  ▼                                  ▼
     Memory Runtime                   Workflow Runtime                  Notification Service
                                              │
                                              ▼
                                  PostgreSQL | Redis | Qdrant
```

---

# 4. Runtime Architecture

The system is divided into four independent runtimes.

## 4.1 Plugin Runtime

Responsible for ingesting data from external systems.

Examples:

* Telegram
* WhatsApp *(where officially supported)*
* Gmail
* Calendar
* Browser Extension
* GitHub
* CSV
* PDF

Responsibilities:

* Authentication
* Data ingestion
* Normalization
* Event publishing

Plugins never contain business logic.

---

## 4.2 Module Runtime

Contains business capabilities.

Examples:

* Finance
* Health
* Goals
* Shopping
* Journal
* Career
* Knowledge

Each module owns:

* Database schema
* APIs
* Services
* Rules
* Events
* AI prompts

Modules communicate through events instead of direct dependencies.

---

## 4.3 Agent Runtime

Responsible for reasoning.

Initial agents:

* Planner Agent
* Finance Agent
* Health Agent
* Research Agent
* Memory Agent
* Notification Agent

The Planner Agent coordinates all other agents.

---

## 4.4 Memory Runtime

Stores long-term context.

Memory types:

* Conversation Memory
* Semantic Memory
* Financial Memory
* Health Memory
* Decision Memory
* Knowledge Memory

Storage:

* PostgreSQL (structured)
* Qdrant (vector search)
* Object Storage (documents)

---

# 5. Event-Driven Architecture

Every meaningful action produces an immutable event.

Example:

```text
Expense Created
        │
        ▼
Budget Updated
        │
        ▼
Goal Progress Updated
        │
        ▼
Analytics Updated
        │
        ▼
Decision Memory Updated
        │
        ▼
Notification Sent
```

Benefits:

* Loose coupling
* Easy extensibility
* Better observability
* Replayability
* Independent modules

---

# 6. Canonical Event

Every plugin publishes the same event structure.

```json
{
  "id": "uuid",
  "version": "1",
  "source": "telegram",
  "type": "expense.created",
  "timestamp": "ISO-8601",
  "correlationId": "uuid",
  "payload": {},
  "metadata": {}
}
```

---

# 7. Plugin Architecture

Every integration implements the Plugin SDK.

Responsibilities:

* Connect to external service
* Normalize incoming data
* Publish canonical events

Plugins must not:

* Query databases directly
* Modify business rules
* Call other modules

---

# 8. Module Architecture

Each module follows the same layout.

```text
finance/
├── api/
├── application/
├── domain/
├── infrastructure/
├── repository/
├── events/
├── prompts/
├── workflows/
└── tests/
```

The same structure applies to every module.

---

# 9. Agent Architecture

Agents are specialized reasoning components.

Planner Agent responsibilities:

* Understand user intent
* Gather context
* Select tools
* Invoke other agents
* Produce final response

Agents remain stateless whenever possible and use the Memory Runtime for persistent context.

---

# 10. Data Flow

Example: Expense Capture

```text
Telegram
      │
      ▼
Telegram Plugin
      │
      ▼
Canonical Event
      │
      ▼
Event Bus
      │
      ▼
Finance Module
      │
      ▼
Expense Stored
      │
      ▼
Memory Updated
      │
      ▼
Budget Recalculated
      │
      ▼
Notification Generated
```

---

# 11. Technology Stack

| Layer        | Technology                               |
| ------------ | ---------------------------------------- |
| Mobile       | Flutter                                  |
| Backend      | FastAPI                                  |
| Database     | PostgreSQL                               |
| Cache        | Redis                                    |
| Event Bus    | Redis Streams (initial), Kafka (future)  |
| Vector Store | Qdrant                                   |
| AI           | Ollama (default), external LLMs optional |
| Automation   | n8n                                      |
| Containers   | Docker Compose                           |

---

# 12. Scalability Strategy

Phase 1:

* Modular Monolith
* Single PostgreSQL instance
* Redis Streams
* Docker Compose

Phase 2:

* Independent services for high-load modules
* Kafka
* Kubernetes
* Horizontal scaling

The architecture should evolve without changing module boundaries.

---

# 13. Security Principles

* Least privilege
* Secrets managed outside source control
* Encrypted communication
* Audit logging
* Explicit user consent for integrations
* Local-first processing where practical

---

# 14. Extensibility

Adding a new capability should require creating one of the following:

* A new Plugin
* A new Module
* A new Agent
* A new Workflow

Existing code should require little or no modification.

---

# 15. Future Enhancements

* Knowledge Graph
* Voice Interface
* Wearable Integrations
* Smart Home Integrations
* Plugin Marketplace
* Agent Marketplace
* Workflow Marketplace
* Multi-device synchronization

---

# 16. Guiding Rule

> **The architecture must allow new capabilities to be added through extension rather than modification.**
