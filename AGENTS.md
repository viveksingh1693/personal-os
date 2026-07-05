# AGENTS.md

> **Agent Architecture Specification — Personal OS v1.0**

---

# Overview

Agents are the intelligence layer of Personal OS.

They are responsible for reasoning, planning, analysis, and recommendation generation.

Agents **do not own business logic**, **do not own data**, and **do not communicate directly with external systems**.

Instead, they orchestrate existing platform capabilities through the Kernel.

---

# Design Philosophy

Personal OS follows a **multi-agent architecture** rather than relying on a single monolithic AI assistant.

Each agent specializes in a specific domain and collaborates through the Kernel.

Benefits include:

* Better reasoning
* Smaller prompts
* Domain specialization
* Easier testing
* Independent evolution
* Lower operational cost
* Explainable execution

---

# Agent Responsibilities

Agents are responsible for:

* Understanding user intent
* Planning execution
* Retrieving relevant context
* Selecting capabilities
* Calling tools
* Performing reasoning
* Producing recommendations
* Explaining decisions

Agents are **not** responsible for:

* Business calculations
* Database access
* External integrations
* Authentication
* Workflow execution
* Long-term memory storage

---

# Agent Runtime Architecture

```text id="mry1vx"
                     User Request
                           │
                           ▼
                    Planner Agent
                           │
            Build Execution Plan
                           │
                           ▼
                Capability Registry
                           │
      ┌───────────────┬───────────────┬───────────────┐
      ▼               ▼               ▼               ▼
 Finance Agent   Health Agent   Research Agent   Memory Agent
      │               │               │               │
      └───────────────┼───────────────┼───────────────┘
                      ▼
              Response Aggregator
                      │
                      ▼
               Decision Runtime
                      │
                      ▼
                 Final Response
```

---

# Agent Lifecycle

Every agent follows the same lifecycle.

```text id="s2hvw4"
Register
      │
      ▼
Initialize
      │
      ▼
Ready
      │
      ▼
Execute
      │
      ▼
Idle
      │
      ▼
Stop
```

Lifecycle management is handled by the Kernel.

---

# Agent Types

## Planner Agent

The Planner Agent coordinates execution.

Responsibilities:

* Intent recognition
* Execution planning
* Agent selection
* Capability discovery
* Result aggregation

The Planner Agent never performs domain reasoning.

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

---

## Knowledge Agent

Responsible for:

* Document retrieval
* Semantic search
* Knowledge synthesis
* Citation generation

Consumes the Knowledge Runtime.

---

## Memory Agent

Responsible for:

* Memory retrieval
* Context summarization
* Memory consolidation
* Context prioritization

Consumes the Memory Runtime.

---

## Research Agent

Responsible for:

* External research
* Information comparison
* Multi-source synthesis
* Market analysis

---

## Notification Agent

Responsible for generating user-facing notifications.

Examples:

* Daily summaries
* Budget alerts
* Goal reminders

---

# Agent Communication

Agents never communicate directly.

Correct:

```text id="ys8if4"
Planner

↓

Finance Agent

↓

Planner

↓

Research Agent

↓

Planner
```

Incorrect:

```text id="y4d1v3"
Finance Agent

↓

Health Agent
```

The Planner coordinates all communication.

---

# Agent Context

Every execution receives:

* User request
* Relevant memories
* Relevant knowledge
* Available capabilities
* Tool results
* Current time
* Configuration

Agents receive only the minimum context necessary.

---

# Capability Discovery

Agents never instantiate components.

Instead they request capabilities.

Example:

```text id="nv5wy8"
finance.expense.create
```

The Kernel resolves the provider.

---

# Tool Usage

Agents interact with the outside world only through tools.

Examples:

* Search Tool
* Browser Tool
* Calculator Tool
* OCR Tool
* Weather Tool
* Currency Tool
* File System Tool

Tools are deterministic.

Agents perform reasoning using tool outputs.

---

# Memory Access

Agents retrieve memory through the Memory Runtime.

```text id="73l1k8"
Agent

↓

Memory Runtime

↓

Relevant Memories
```

Agents never store memory directly.

---

# Knowledge Access

Knowledge retrieval is handled through the Knowledge Runtime.

Examples:

* PDFs
* Documentation
* Articles
* Research papers
* Web content

This keeps user memory separate from external knowledge.

---

# Decision Making

Agents support decisions by providing:

* Evidence
* Alternatives
* Assumptions
* Risks
* Confidence

The Decision Runtime composes the final recommendation.

---

# Prompt Management

Prompts belong to components rather than agents.

Example:

```text id="ttqvpd"
components/

modules/

finance/

prompts/

purchase-evaluation.md
```

Agents load prompts dynamically through the Kernel.

---

# Response Contract

Every agent returns a standardized response.

```json id="4zlfva"
{
  "agent": "finance",
  "confidence": 0.92,
  "summary": "...",
  "recommendations": [],
  "evidence": [],
  "assumptions": [],
  "risks": [],
  "nextActions": []
}
```

Responses are aggregated by the Planner.

---

# Observability

Every execution records:

* Request ID
* Correlation ID
* Agent
* Duration
* Tools used
* Memory retrieved
* Knowledge retrieved
* Tokens consumed
* Success or failure

These metrics support debugging and optimization.

---

# Security

Agents must:

* Respect user permissions
* Request minimum context
* Avoid retaining state
* Never access secrets directly
* Never bypass the Kernel

---

# Extensibility

Adding a new agent requires:

1. Implement the Agent SDK
2. Register metadata
3. Declare capabilities
4. Declare required tools
5. Declare required runtimes
6. Register prompts
7. Add tests
8. Register with the Component Registry

Existing agents should never require modification.

---

# Future Evolution

The architecture supports future additions such as:

* Hierarchical planners
* Collaborative multi-user agents
* Background monitoring agents
* Reflection and self-evaluation
* Multi-model execution
* Human approval workflows
* Continuous reasoning

These capabilities should extend the existing framework rather than replace it.

---

# Guiding Principles

* Agents reason.
* Modules own business logic.
* Tools perform deterministic actions.
* Plugins connect external systems.
* Workflows orchestrate execution.
* Memory preserves user context.
* Knowledge represents the external world.
* The Kernel coordinates everything.

---

# Agent Ecosystem

```text id="j5huz8"
                        Personal OS Kernel
                                │
                                ▼
                      Component Registry
                                │
                                ▼
                       Capability Registry
                                │
                                ▼
                        Planner Agent
                                │
        ┌───────────────┬───────────────┬───────────────┐
        ▼               ▼               ▼               ▼
 Finance Agent   Health Agent   Memory Agent   Research Agent
        │               │               │               │
        └───────────────┼───────────────┼───────────────┘
                        ▼
                 Decision Runtime
                        │
                        ▼
                  Final Recommendation
```

---

# Guiding Statement

> **Agents provide intelligence, not ownership. They reason using capabilities exposed by the platform, while the Kernel orchestrates execution, the runtimes manage state, and the Decision Runtime produces transparent, explainable recommendations.**
