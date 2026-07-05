# ARCHITECTURE.md

> **Personal OS v1.0 (Frozen Architecture)**

---

# Overview

Personal OS is an AI-first, event-driven, modular platform designed to help users make better decisions throughout their lives.

Unlike traditional applications, Personal OS is built around a **Kernel** that manages the lifecycle, discovery, orchestration, and communication of every component in the system.

The architecture is designed to support long-term evolution while maintaining clear separation of concerns, extensibility, and testability.

---

# Architecture Principles

The architecture is built on the following principles:

* Kernel-first architecture
* Component-based design
* Capability-driven discovery
* Event-driven communication
* Modular business domains
* Hexagonal Architecture
* Domain-Driven Design
* Explainable AI
* User-owned data
* Extensibility over modification

---

# High-Level Architecture

```text
                                      Applications
┌────────────────────────────────────────────────────────────────────────────┐
│  Flutter Mobile │ Web │ Desktop │ CLI │ REST API │ Future Integrations     │
└───────────────────────────────┬────────────────────────────────────────────┘
                                │
                                ▼
┌────────────────────────────────────────────────────────────────────────────┐
│                          Personal OS Kernel                               │
└────────────────────────────────────────────────────────────────────────────┘
                                │
      ┌─────────────────────────┼─────────────────────────┐
      ▼                         ▼                         ▼
 Component Registry     Capability Registry      Lifecycle Manager
      │                         │                         │
      └─────────────────────────┼─────────────────────────┘
                                ▼
                      Dependency Resolver
                                │
                                ▼
┌────────────────────────────────────────────────────────────────────────────┐
│                            Runtime Layer                                  │
├────────────────────────────────────────────────────────────────────────────┤
│ Event Runtime                                                             │
│ Workflow Runtime                                                          │
│ Memory Runtime                                                            │
│ Knowledge Runtime                                                         │
│ Decision Runtime                                                          │
│ Scheduler Runtime                                                         │
└────────────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌────────────────────────────────────────────────────────────────────────────┐
│                         Platform Services                                 │
├────────────────────────────────────────────────────────────────────────────┤
│ Configuration │ Database │ Redis │ Messaging │ AI Providers │ Logging      │
│ Authentication │ Authorization │ Storage │ Monitoring │ Telemetry         │
└────────────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌────────────────────────────────────────────────────────────────────────────┐
│                             Components                                    │
├────────────────────────────────────────────────────────────────────────────┤
│ Modules │ Plugins │ Agents │ Workflows │ Tools                            │
└────────────────────────────────────────────────────────────────────────────┘
```

---

# Layered Architecture

## 1. Applications

Applications are the user-facing interfaces.

Examples:

* Flutter Mobile App
* Web Application
* Desktop Application
* Command Line Interface
* REST API

Applications contain no business logic.

Their responsibility is to present information and invoke capabilities.

---

## 2. Kernel

The Kernel is the operating system of Personal OS.

It is responsible for:

* Bootstrapping the platform
* Component discovery
* Component lifecycle
* Capability discovery
* Dependency resolution
* Runtime orchestration

The Kernel has no knowledge of Finance, Health, or any other business domain.

---

# Kernel Components

## Runtime

Coordinates system startup and shutdown.

---

## Component Registry

Tracks every registered component.

Supported component types:

* Module
* Plugin
* Agent
* Workflow
* Tool

---

## Capability Registry

Maps capabilities to their providers.

Example:

```text
finance.expense.create

↓

Finance Module
```

The caller requests a capability instead of a concrete implementation.

---

## Lifecycle Manager

Controls:

* Register
* Initialize
* Start
* Ready
* Stop
* Destroy

Every component follows the same lifecycle.

---

## Dependency Resolver

Determines startup order based on declared dependencies.

---

# Runtime Layer

The Runtime Layer provides core execution services.

---

## Event Runtime

Responsibilities:

* Publish events
* Subscribe to events
* Event routing
* Event replay
* Dead Letter Queue

All cross-component communication should occur through events or public APIs.

---

## Workflow Runtime

Executes workflows.

Responsibilities:

* Workflow execution
* Scheduling
* Retry
* Compensation
* Workflow state

---

## Memory Runtime

Stores user-specific long-term context.

Memory types:

* Working
* Episodic
* Semantic
* Procedural
* Decision

---

## Knowledge Runtime

Stores external knowledge.

Examples:

* Documents
* Articles
* PDFs
* Books
* Web pages

The Knowledge Runtime is intentionally separated from the Memory Runtime.

---

## Decision Runtime

Combines:

* Business rules
* Memory
* Knowledge
* AI reasoning
* External information

to produce explainable recommendations.

---

## Scheduler Runtime

Executes scheduled workflows and background tasks.

---

# Platform Layer

The Platform Layer provides shared infrastructure.

Services include:

* Configuration
* Database
* Cache
* Messaging
* Authentication
* Authorization
* Storage
* Logging
* Monitoring
* Telemetry
* AI Provider Abstraction

Platform services contain no business logic.

---

# Component Model

Everything inside Personal OS is a Component.

```text
Component

├── Module
├── Plugin
├── Agent
├── Workflow
└── Tool
```

Every component implements a common lifecycle and registers itself with the Kernel.

---

# Modules

Modules own business capabilities.

Examples:

* Finance
* Health
* Goals
* Calendar
* Shopping
* Knowledge
* Career
* Travel

Modules own:

* Domain models
* Business rules
* APIs
* Events
* Workflows
* AI prompts

---

# Plugins

Plugins connect Personal OS to external systems.

Examples:

* Telegram
* Gmail
* Browser
* GitHub
* CSV Import
* OCR

Plugins:

* Authenticate
* Read data
* Normalize data
* Publish events

Plugins never contain business logic.

---

# Agents

Agents provide reasoning.

Examples:

* Planner
* Finance
* Memory
* Research

Agents:

* Consume context
* Invoke tools
* Produce recommendations

Agents never own business data.

---

# Tools

Tools perform deterministic operations.

Examples:

* Search
* OCR
* Weather
* Calculator
* Currency Conversion
* File System

Tools are stateless and reusable.

---

# Workflows

Workflows orchestrate execution.

Examples:

* Monthly Financial Report
* Expense Processing
* Reminder Generation
* Daily Summary

Workflows coordinate components without owning business logic.

---

# Communication Model

Components communicate using:

1. Events
2. Public APIs

Direct access to another component's persistence layer is prohibited.

---

# Capability Model

Components advertise capabilities.

Example:

```yaml
id: finance

capabilities:

- finance.expense.create

- finance.expense.search

- finance.budget.calculate
```

Consumers request capabilities rather than concrete implementations.

This minimizes coupling.

---

# Event Flow

```text
User Request
      │
      ▼
Planner Agent
      │
      ▼
Capability Registry
      │
      ▼
Selected Component
      │
      ▼
Domain Event
      │
      ▼
Event Runtime
      │
      ├── Memory Runtime
      ├── Decision Runtime
      ├── Workflow Runtime
      └── Other Components
```

---

# Repository Organization

```text
personal-os/

apps/
backend/
kernel/
platform/
components/
sdk/
docs/
infrastructure/
tests/
scripts/
```

This structure separates:

* Runtime
* Infrastructure
* Business domains
* SDKs
* Applications

---

# Dependency Rules

Allowed:

Applications

↓

Kernel

↓

Platform

↓

SDK

↓

Components

Forbidden:

* Module → Module persistence access
* Plugin → Business logic
* Agent → Direct database access
* Workflow → Business calculations

---

# Architectural Decisions

Major architectural changes must be documented using Architecture Decision Records (ADRs).

Examples:

* ADR-0001 Kernel-first architecture
* ADR-0002 Component model
* ADR-0003 Capability registry
* ADR-0004 Event-driven communication
* ADR-0005 Hexagonal Architecture

The repository structure and architectural principles defined in this document are considered **frozen for v1.0**.

---

# Guiding Principle

> **The Kernel orchestrates. Components provide capabilities. Events connect the platform. Memory preserves user context. Knowledge represents the external world. The Decision Runtime combines them to help users make transparent, explainable, and trustworthy decisions.**
