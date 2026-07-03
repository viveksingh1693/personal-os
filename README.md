# Personal OS

> **An AI-first, modular Personal Operating System that helps you make better decisions by understanding your life, not just your conversations.**

---

## Vision

Personal OS is an open-source platform that acts as a lifelong intelligent companion.

Instead of building isolated applications for finance, health, productivity, or planning, Personal OS provides a unified intelligence layer capable of understanding context across every aspect of your life.

The long-term goal is to create a privacy-first, extensible platform where new capabilities can be added through plugins, specialized AI agents, and workflows.

---

# Why Personal OS?

Today's AI assistants answer questions.

Personal OS understands:

* Your finances
* Your goals
* Your health
* Your calendar
* Your habits
* Your decisions
* Your knowledge
* Your long-term plans

It doesn't simply answer prompts.

It helps you make better decisions.

---

# Core Principles

## 🔌 Everything is a Plugin

Every external integration should be implemented as a plugin.

Examples:

* WhatsApp *(where officially supported)*
* Telegram
* Gmail
* Google Calendar
* Browser Extension
* Web Crawler *(respecting robots.txt and website terms of service)*
* GitHub
* Notion
* CSV Import
* PDF Import

Plugins should never contain business logic.

Their only responsibility is ingesting and normalizing data.

---

## 📦 Everything is a Module

Each domain is independent.

Examples:

* Finance
* Health
* Goals
* Shopping
* Career
* Travel
* Knowledge
* Journal
* Habits

Every module owns:

* APIs
* Services
* Database models
* Business rules
* Events
* AI prompts

---

## ⚡ Everything is an Event

Modules communicate through events rather than direct dependencies.

Example:

```text
Expense Created
      │
      ▼
Budget Updated
      │
      ▼
Analytics Updated
      │
      ▼
Goal Progress Updated
      │
      ▼
Memory Updated
      │
      ▼
Notification Sent
```

This keeps the platform modular and scalable.

---

## 🤖 Everything is an Agent

Instead of one giant prompt, Personal OS uses specialized AI agents.

Examples:

* Planner Agent
* Finance Agent
* Health Agent
* Research Agent
* Shopping Agent
* Notification Agent
* Memory Agent
* Decision Agent

The Planner Agent orchestrates them.

---

# High-Level Architecture

```text
                           Clients
               Flutter • Web • Desktop • CLI
                           │
                           ▼
                    API Gateway / BFF
                           │
                           ▼
                  Agent Orchestrator
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
         ▼                 ▼                 ▼
     Plugin Runtime   Module Runtime   Agent Runtime
         │                 │                 │
         └─────────────────┼─────────────────┘
                           │
                           ▼
                     Event Bus
                           │
                           ▼
                     Memory Engine
                           │
                           ▼
          PostgreSQL • Vector DB • Object Storage
```

---

# Planned Features

## Personal Finance

* Expense tracking
* Budget management
* Investment tracking
* Savings analysis
* Net worth tracking
* Financial insights
* Purchase recommendations

---

## Health

* Workout tracking
* Sleep tracking
* Diet planning
* Medical records
* Health reminders

---

## Productivity

* Calendar intelligence
* Daily planning
* Habit tracking
* Journal
* Meeting preparation

---

## Knowledge

* Notes
* Documents
* Bookmarks
* Research
* Personal wiki

---

## Decision Engine

Examples:

* Should I buy this car?
* Should I purchase a house?
* Can I afford this vacation?
* Should I switch jobs?
* Am I saving enough?
* What is my biggest financial mistake this month?

---

# Planned Plugin Ecosystem

* Telegram
* WhatsApp *(where officially supported)*
* Gmail
* Google Calendar
* Browser Extension
* GitHub
* Notion
* Google Drive
* CSV Import
* PDF Import
* Web Crawler *(respecting robots.txt and website policies)*

---

# Technology Stack

## Backend

* FastAPI
* PostgreSQL
* Redis
* Kafka / Redis Streams
* Qdrant

## AI

* Ollama
* Qwen
* Llama
* OpenAI (optional)

## Client

* Flutter
* Web (planned)
* Desktop (planned)

## Automation

* n8n

## Infrastructure

* Docker Compose
* Kubernetes (future)

---

# Repository Structure

```text
personal-os/

├── apps/
├── backend/
├── agents/
├── modules/
├── plugins/
├── sdk/
├── infrastructure/
├── workflows/
├── docs/
├── scripts/
├── tests/
│
├── README.md
├── PROJECT.md
├── ARCHITECTURE.md
├── AGENTS.md
├── ROADMAP.md
└── LICENSE
```

---

# Development Roadmap

## Phase 1

* Project foundation
* Documentation
* Docker setup
* FastAPI backend
* Flutter application
* Plugin SDK

---

## Phase 2

Finance module

* Expenses
* Budget
* Investments
* Analytics

---

## Phase 3

Memory Engine

* Long-term memory
* Semantic search
* Decision history

---

## Phase 4

Multi-Agent Runtime

* Planner Agent
* Finance Agent
* Health Agent
* Research Agent

---

## Phase 5

Plugin Ecosystem

* Messaging
* Email
* Calendar
* Browser
* Document ingestion

---

## Phase 6

Personal Decision Engine

A unified reasoning engine capable of making recommendations using information across all modules.

---

# Contributing

Personal OS is designed as a modular open-source platform.

Contributions are welcome.

Before opening a Pull Request, please read:

* `PROJECT.md`
* `ARCHITECTURE.md`
* `AGENTS.md`
* `CONTRIBUTING.md`

---

# License

MIT License

---

# Project Status

🚧 **Early Development**

This project is currently focused on building a strong architectural foundation before implementing individual features.

The long-term vision is to create a modular, privacy-first Personal Operating System capable of helping users make better decisions throughout their lives.
