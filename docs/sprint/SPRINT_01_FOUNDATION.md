# SPRINT_01_FOUNDATION.md

> Sprint Goal: Build the foundational runtime of Personal OS without implementing any business features.

---

# Sprint Objective

At the end of Sprint 1, Personal OS should be a runnable platform capable of:

* Starting successfully
* Registering modules
* Registering plugins
* Registering agents
* Publishing events
* Executing workflows
* Performing health checks
* Exposing APIs

No Finance or Health features will be implemented during this sprint.

The goal is to build the platform, not the product.

---

# Success Criteria

By the end of this sprint:

✅ Docker Compose starts every service

✅ FastAPI starts successfully

✅ PostgreSQL connected

✅ Redis connected

✅ Ollama connected

✅ Module Registry initialized

✅ Plugin Registry initialized

✅ Agent Registry initialized

✅ Event Bus operational

✅ Configuration loaded

✅ Health endpoint available

---

# Architecture

```text id="vsl2j9"
                FastAPI

                   │

        ┌──────────┼──────────┐

        ▼          ▼          ▼

 Module Registry  Plugin Registry  Agent Registry

        │          │          │

        └──────────┼──────────┘

                   ▼

             Event Bus

                   │

                   ▼

         Workflow Runtime

                   │

                   ▼

       PostgreSQL • Redis
```

---

# Deliverables

## 1. Project Bootstrap

Create:

```text id="b3tm0x"
backend/

apps/

modules/

plugins/

agents/

sdk/

shared/

tests/
```

---

## 2. Configuration System

Configuration should support:

* Environment Variables
* Local Development
* Docker
* Production

Example

```yaml id="p8v08v"
app:

name: Personal OS

environment: local
```

---

## 3. Dependency Injection

Create a dependency container.

Responsibilities:

* Register services
* Register modules
* Register plugins
* Register agents

No service should manually instantiate another service.

---

# Module Registry

Responsibilities

* Discover modules
* Register modules
* Start modules
* Stop modules
* Health checks

Example

```text id="kk5ttx"
Finance

Health

Goals

Knowledge
```

Initially these are placeholders.

---

# Plugin Registry

Responsibilities

* Discover plugins
* Load configuration
* Start plugins
* Stop plugins
* Validate permissions

Example

```text id="gdrd73"
Telegram

Browser

CSV

PDF
```

---

# Agent Registry

Responsibilities

* Register agents
* Discover capabilities
* Execute agent
* Health check

Initially

```text id="oj5yvj"
Planner Agent
```

only.

---

# Event Bus

Implement abstraction.

Initial backend

```text id="spfxij"
Redis Streams
```

Future

```text id="l7qfha"
Kafka
```

Business code must not depend on the implementation.

---

# Workflow Runtime

Support

* Register workflow
* Execute workflow
* Retry
* Log execution

No visual builder yet.

---

# Logging

Every request gets

```text id="5bm0x8"
Correlation ID

Request ID

Timestamp
```

Structured logging only.

---

# Observability

Provide:

```text id="9wtd1u"
GET /health

GET /ready

GET /metrics
```

Health should include:

* Database
* Redis
* Event Bus
* Plugins
* Modules
* Agents

---

# Security

Implement:

* Secret loading
* Environment validation
* CORS
* Request logging

Authentication comes in Sprint 2.

---

# Tests

Minimum coverage:

* Configuration
* Module Registry
* Plugin Registry
* Event Bus
* Agent Registry

No business tests yet.

---

# Docker Compose

Services

```text id="f8dtdk"
postgres

redis

ollama

n8n

backend
```

Future additions:

* Qdrant
* Grafana
* Prometheus

---

# Out of Scope

Not included in Sprint 1:

* Expense tracking
* AI reasoning
* Memory storage
* Notifications
* Mobile UI
* Authentication
* OCR

---

# Sprint Deliverables

Repository should contain:

```text id="efu98i"
backend/

shared/

modules/

plugins/

agents/

sdk/

docker-compose.yml

README.md

Configuration

Health APIs

Docker setup
```

---

# Exit Criteria

Sprint 1 is complete when:

* Every runtime starts successfully.
* All registries initialize.
* The Event Bus can publish and subscribe.
* Health checks report all core services.
* The project can be started with a single command:

```bash
docker compose up
```

No feature work begins until the platform foundation is stable.

---

# Guiding Principle

> **Build infrastructure once. Build features forever.**
