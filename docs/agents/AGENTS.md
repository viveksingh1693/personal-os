# AGENTS.md

> **Agent Framework Specification for Personal OS**

**Version:** 1.0
**Status:** Active
**Architecture:** Frozen

---

# Overview

Agents are the intelligence layer of Personal OS.

They are responsible for understanding user intent, reasoning over available context, planning execution, invoking capabilities, and producing explainable recommendations.

Agents **do not own business logic**, **do not own persistent data**, and **do not directly access infrastructure**.

They operate through the Kernel using Capabilities exposed by Components.

---

# Philosophy

Personal OS follows a **multi-agent architecture**.

Instead of one large AI assistant attempting to solve every problem, the platform consists of specialized agents responsible for distinct domains.

This provides:

* Better reasoning
* Smaller prompts
* Clear responsibilities
* Easier testing
* Independent evolution
* Lower operational cost
* Better observability

---

# Agent Design Principles

Every agent should be:

* Stateless
* Explainable
* Context-aware
* Capability-driven
* Observable
* Replaceable
* Testable

Agents should coordinate intelligence—not own business rules.

---

# Responsibilities

Agents are responsible for:

* Intent recognition
* Context understanding
* Execution planning
* Capability selection
* Tool selection
* AI reasoning
* Recommendation generation
* Result summarization
* Decision explanation

Agents are **not** responsible for:

* Business calculations
* Persistence
* Authentication
* External integrations
* Workflow execution
* Event routing

---

# Agent Architecture

```text id="v4t8rh"
                 User Request
                       │
                       ▼
                Planner Agent
                       │
      ┌────────────────┼────────────────┐
      ▼                ▼                ▼
 Finance Agent   Health Agent   Research Agent
      │                │                │
      └────────────────┼────────────────┘
                       ▼
               Memory Agent
                       │
                       ▼
             Decision Engine
                       │
                       ▼
               Final Response
```

The Planner Agent coordinates execution.

Domain Agents specialize in reasoning.

---

# Agent Lifecycle

Every Agent follows the standard Component lifecycle.

```text id="u0hqkh"
Register

↓

Initialize

↓

Ready

↓

Execute

↓

Idle

↓

Stop

↓

Destroy
```

The Kernel manages lifecycle transitions.

---

# Agent Categories

## Planner Agent

The Planner Agent is the primary orchestrator.

Responsibilities:

* Intent detection
* Execution planning
* Capability resolution
* Agent coordination
* Response aggregation

The Planner Agent should remain domain-agnostic.

---

## Domain Agents

Domain Agents specialize in a business area.

Examples:

* Finance Agent
* Health Agent
* Shopping Agent
* Calendar Agent
* Career Agent

Responsibilities:

* Domain reasoning
* Recommendation generation
* Context interpretation
* Trade-off analysis

Business rules remain inside Modules.

---

## Memory Agent

Responsible for:

* Memory retrieval
* Context prioritization
* Memory summarization
* Memory consolidation requests

Consumes the Memory Runtime.

---

## Knowledge Agent

Responsible for:

* Knowledge retrieval
* Semantic search
* Document synthesis
* Citation generation

Consumes the Knowledge Runtime.

---

## Research Agent

Responsible for:

* External research
* Information comparison
* Market analysis
* Trend identification

---

## Notification Agent

Responsible for:

* Notification generation
* Delivery planning
* Communication summarization

---

# Agent Communication

Agents never communicate directly.

Correct:

```text id="i2vw0r"
Planner

↓

Finance Agent

↓

Planner

↓

Knowledge Agent

↓

Planner
```

Incorrect:

```text id="e3o70u"
Finance Agent

↓

Health Agent
```

The Planner Agent coordinates all interactions.

---

# Agent Context

Every execution receives a context package containing:

* User request
* Relevant memories
* Relevant knowledge
* Available capabilities
* User preferences
* Configuration
* Current time
* Active workflows

Agents receive only the minimum context required.

---

# Capability Discovery

Agents never instantiate Components directly.

Preferred:

```python id="7z0y2l"
kernel.execute(
    "finance.expense.create"
)
```

Avoid:

```python id="m0ijld"
FinanceService()
```

Capability discovery minimizes coupling.

---

# Tool Usage

Agents interact with deterministic Tools.

Examples:

* Calculator
* Search
* Browser
* OCR
* Currency Conversion
* Weather
* File System

Tools perform deterministic operations.

Agents interpret the results.

---

# Memory Integration

Agents retrieve context through the Memory Runtime.

Examples:

* User preferences
* Previous decisions
* Goals
* Habits
* Long-term context

Agents never write directly to Memory.

---

# Knowledge Integration

Agents retrieve external information through the Knowledge Runtime.

Examples:

* Documentation
* PDFs
* Research papers
* Articles
* Web content

Knowledge remains separate from user memory.

---

# Decision Support

Agents contribute recommendations by providing:

* Summary
* Evidence
* Alternatives
* Risks
* Assumptions
* Confidence

The Decision Engine combines these into the final recommendation.

---

# Prompt Management

Prompts belong to Components rather than Agents.

Example:

```text id="qih4m6"
components/

modules/

finance/

prompts/

purchase-evaluation.md
```

Agents request prompts dynamically through the Kernel.

---

# Standard Response

Every Agent returns a consistent structure.

```json id="2frg7m"
{
  "agent": "finance",
  "confidence": 0.91,
  "summary": "...",
  "recommendations": [],
  "evidence": [],
  "assumptions": [],
  "risks": [],
  "nextActions": []
}
```

Responses are merged by the Planner Agent.

---

# Security

Agents should:

* Respect authorization
* Minimize retrieved context
* Avoid retaining state
* Never access secrets
* Never bypass the Kernel

---

# Observability

Every execution records:

* Agent ID
* Correlation ID
* Request ID
* Execution time
* Tokens consumed
* Tools used
* Memory retrieved
* Knowledge retrieved
* Capabilities invoked
* Success or failure

These metrics support debugging and optimization.

---

# Agent Development Guidelines

Every new Agent should:

1. Implement the Agent SDK.
2. Register metadata.
3. Declare capabilities.
4. Declare required tools.
5. Declare required runtimes.
6. Register prompts.
7. Provide automated tests.
8. Register with the Component Registry.

No changes to existing Agents should be required.

---

# Future Evolution

The architecture supports future capabilities including:

* Hierarchical planning
* Multi-agent collaboration
* Reflection and self-evaluation
* Multi-model execution
* Background monitoring agents
* Human approval workflows
* Continuous reasoning
* Autonomous planning

These should extend the framework rather than replace it.

---

# Relationship with Other Components

```text id="q2nb6m"
User
      │
      ▼
Planner Agent
      │
      ▼
Capability Registry
      │
      ▼
Modules / Plugins / Tools
      │
      ▼
Memory Runtime
      │
      ▼
Knowledge Runtime
      │
      ▼
Decision Engine
      │
      ▼
Response
```

Agents consume capabilities—they do not own them.

---

# Success Criteria

An effective Agent Framework should:

* Support specialized reasoning.
* Minimize coupling.
* Produce explainable recommendations.
* Remain stateless.
* Scale with new business domains.
* Integrate cleanly with the Kernel.

---

# Guiding Principles

* The Kernel orchestrates.
* Agents reason.
* Modules own business logic.
* Plugins integrate external systems.
* Tools perform deterministic work.
* Workflows coordinate execution.
* Memory provides user context.
* Knowledge provides world context.
* The Decision Engine synthesizes recommendations.

---

# Guiding Statement

> **Agents are the reasoning layer of Personal OS. They transform user intent, memory, knowledge, and capabilities into transparent, explainable recommendations while remaining stateless, modular, and independent of business logic. Their purpose is to augment human judgment—not replace it.**
