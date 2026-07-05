# AGENT_FRAMEWORK.md

> Defines the Agent Runtime, execution model, orchestration, lifecycle, communication protocol, and extensibility of AI agents in Personal OS.

---

# 1. Purpose

The Agent Framework is responsible for executing AI-powered reasoning across the platform.

It provides a common runtime for all agents while keeping them:

* Independent
* Stateless
* Replaceable
* Observable
* Extensible

The framework separates **reasoning** from **business logic**.

Business logic belongs to modules.

Reasoning belongs to agents.

---

# 2. Philosophy

Personal OS does not use one giant AI prompt.

Instead it uses a collection of specialized agents coordinated by an orchestrator.

Benefits include:

* Better reasoning
* Easier testing
* Lower token usage
* Better observability
* Independent evolution
* Domain specialization

---

# 3. Runtime Architecture

```text
                    User

                      │

                      ▼

              Planner Agent

                      │

       ┌──────────────┼──────────────┐

       ▼              ▼              ▼

 Finance Agent   Health Agent   Research Agent

       │              │              │

       └──────────────┼──────────────┘

                      ▼

              Memory Runtime

                      │

                      ▼

             Final Recommendation
```

The Planner Agent coordinates execution.

Other agents never coordinate one another.

---

# 4. Framework Components

The Agent Framework consists of:

## Planner

Coordinates execution.

---

## Agent Registry

Discovers available agents.

---

## Tool Registry

Provides tools.

---

## Memory Gateway

Retrieves memories.

---

## Context Builder

Builds execution context.

---

## Prompt Engine

Loads prompts.

---

## Response Aggregator

Combines outputs.

---

## Decision Publisher

Publishes results.

---

# 5. Execution Lifecycle

Every request follows the same lifecycle.

```text
Receive Request

↓

Planner

↓

Retrieve Context

↓

Retrieve Memory

↓

Select Agents

↓

Execute Agents

↓

Collect Results

↓

Resolve Conflicts

↓

Compose Final Answer

↓

Store Decision

↓

Publish Events
```

---

# 6. Agent Lifecycle

Every agent follows this lifecycle.

```text
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

Shutdown
```

Agents should be lightweight.

---

# 7. Planner Responsibilities

The Planner Agent should:

* Understand intent
* Build execution plan
* Select agents
* Invoke tools
* Collect responses
* Resolve conflicts
* Produce final recommendation

The Planner should never perform domain reasoning itself.

---

# 8. Agent Registry

The framework automatically discovers agents.

Each agent registers:

* Metadata
* Capabilities
* Supported intents
* Required tools
* Required memory

Example

```yaml
id: finance

capabilities:

- budget

- investments

- affordability
```

---

# 9. Agent Context

Every execution receives:

Current Request

Relevant Memories

Relevant Events

Tool Results

Current Time

Configuration

Only relevant information should be included.

---

# 10. Tool Invocation

Agents never call databases.

Agents only use tools.

Examples

Expense Tool

Calendar Tool

OCR Tool

Browser Tool

Search Tool

Weather Tool

GitHub Tool

Tools perform actions.

Agents reason.

---

# 11. Memory Integration

Agents retrieve memory through the Memory Runtime.

```text
Planner

↓

Memory Runtime

↓

Relevant Memories

↓

Agent
```

Agents never store memory directly.

---

# 12. Communication Model

Agents never communicate directly.

All communication passes through the Planner.

Correct

```text
Planner

↓

Finance

↓

Planner

↓

Health

↓

Planner
```

Incorrect

```text
Finance

↓

Health
```

---

# 13. Parallel Execution

Independent agents may execute simultaneously.

Example

```text
Planner

↓

Finance

Health

Research

↓

Aggregator
```

This reduces latency.

---

# 14. Conflict Resolution

Different agents may disagree.

Example

Finance

Delay purchase.

Shopping

Good deal.

Planner

Compare evidence

↓

Final recommendation.

Planner always resolves conflicts.

---

# 15. Prompt Management

Prompts belong to modules.

The framework loads them dynamically.

Example

```text
modules/

finance/

prompts/

purchase.md
```

Prompts should never be hardcoded.

---

# 16. Response Contract

Every agent returns

```json
{
  "agent":"finance",
  "confidence":0.91,
  "summary":"",
  "recommendations":[],
  "evidence":[],
  "events":[]
}
```

Responses are merged by the Planner.

---

# 17. Observability

Every execution records:

* Request ID
* Correlation ID
* Agent
* Duration
* Tokens
* Tools Used
* Memory Retrieved
* Success/Failure

These metrics support debugging and optimization.

---

# 18. Security

Agents should:

* Request minimum context.
* Respect permissions.
* Never access secrets directly.
* Never bypass the Tool Registry.
* Avoid retaining user data beyond execution.

---

# 19. Extensibility

Adding a new agent requires:

1. Implement Agent interface.
2. Register metadata.
3. Declare capabilities.
4. Declare required tools.
5. Declare required memory.
6. Add tests.
7. Add documentation.

No existing agent should require modification.

---

# 20. Future Evolution

The framework is designed to support:

* Hierarchical planners
* Multi-step planning
* Human approval workflows
* Multi-user collaboration
* Team agents
* Background agents
* Continuous monitoring agents
* Self-evaluation and reflection

These capabilities should build on the same execution model rather than replace it.

---

# 21. Guiding Principle

> **The Agent Framework orchestrates intelligence. Agents specialize in reasoning. Modules own business logic. Tools perform actions. Memory preserves context. The Planner coordinates everything.**
