# EVENT_MODEL.md

> Defines the canonical event model, event lifecycle, versioning strategy, and messaging contract for Personal OS.

---

# 1. Purpose

Everything inside Personal OS communicates using events.

An event represents **something that has already happened**.

Examples:

* Expense Created
* Calendar Event Updated
* Goal Completed
* Workout Logged
* Email Received
* Budget Exceeded
* Reminder Triggered

Events are immutable.

Once published, an event must never be modified.

---

# 2. Why Events?

Event-driven architecture provides:

* Loose coupling
* Independent modules
* Easy extensibility
* Event replay
* Audit history
* Better observability
* Simpler integrations

Instead of:

```text
Telegram Plugin

↓

Finance Module

↓

Budget Module

↓

Analytics Module
```

We publish an event once:

```text
Telegram Plugin

↓

Expense Created

↓

Event Bus

↓

Finance

↓

Analytics

↓

Goals

↓

Memory

↓

Notifications
```

Every interested module reacts independently.

---

# 3. Event Principles

Every event must be:

* Immutable
* Versioned
* Timestamped
* Traceable
* Serializable
* Idempotent
* Backward compatible whenever possible

---

# 4. Event Structure

Every event follows the same envelope.

```json
{
  "id": "evt_01JABCDEF123",
  "type": "finance.expense.created",
  "version": 1,
  "source": "telegram",
  "timestamp": "2026-07-03T12:30:15Z",
  "correlationId": "req_abc123",
  "causationId": "evt_previous",
  "tenantId": "default",
  "actor": {
    "type": "user",
    "id": "user_001"
  },
  "payload": {},
  "metadata": {}
}
```

---

# 5. Event Naming Convention

Format

```text
<domain>.<entity>.<action>
```

Examples

```text
finance.expense.created

finance.expense.updated

finance.budget.exceeded

health.workout.logged

calendar.event.created

memory.note.saved

plugin.telegram.connected

plugin.gmail.failed

notification.sent

workflow.completed
```

Event names should be written in lowercase.

---

# 6. Event Categories

## Domain Events

Represent business changes.

Examples:

* Expense Created
* Goal Completed
* Budget Updated

---

## Integration Events

Produced by plugins.

Examples:

* Telegram Message Received
* Gmail Email Received
* Calendar Event Imported

---

## System Events

Internal runtime events.

Examples:

* Agent Started
* Plugin Registered
* Workflow Completed

---

## Audit Events

Track important operations.

Examples:

* Login
* Configuration Changed
* Permission Granted

---

# 7. Payload Rules

The payload contains only business data.

Good example

```json
{
  "expenseId": "exp123",
  "amount": 420,
  "currency": "INR",
  "category": "Food"
}
```

Avoid embedding provider-specific formats in payloads.

---

# 8. Metadata

Metadata provides operational information.

Examples

```json
{
  "pluginVersion": "1.2.0",
  "schemaVersion": 1,
  "retryCount": 0,
  "receivedAt": "..."
}
```

Business logic should ignore metadata.

---

# 9. Correlation

A single user request can generate many events.

Example

```text
Telegram Message

↓

Expense Created

↓

Budget Updated

↓

Goal Progress Updated

↓

Notification Sent
```

All events share the same **correlationId**.

This enables end-to-end tracing.

---

# 10. Causation

Every event may reference the event that caused it.

Example

```text
Expense Created

↓

Budget Updated

↓

Notification Sent
```

`Budget Updated` references `Expense Created`.

`Notification Sent` references `Budget Updated`.

This forms an event chain.

---

# 11. Event Lifecycle

```text
Created

↓

Validated

↓

Published

↓

Consumed

↓

Processed

↓

Archived
```

Events are never modified after publication.

---

# 12. Event Versioning

Every event has a schema version.

```json
{
  "version": 2
}
```

Rules:

* Additive changes are preferred.
* Avoid breaking changes.
* Consumers should tolerate unknown fields.

---

# 13. Event Ordering

Ordering is guaranteed only within a logical stream (for example, a single aggregate or partition).

Modules should not assume a global event order.

---

# 14. Idempotency

Consumers must be idempotent.

Processing the same event twice must not change the final outcome.

Recommended key:

```text
event.id
```

---

# 15. Event Delivery

Delivery guarantee:

**At least once**

This means duplicates are possible.

Consumers are responsible for deduplication.

---

# 16. Event Replay

The Event Bus should support replay.

Uses:

* Rebuilding projections
* Recovering analytics
* Recomputing budgets
* Debugging
* Testing

Business logic should produce the same result when replaying historical events.

---

# 17. Dead Letter Queue (DLQ)

Events that repeatedly fail processing should be moved to a Dead Letter Queue.

Required metadata:

* Error type
* Stack trace (if applicable)
* Retry count
* Failure timestamp

DLQ events must remain available for investigation.

---

# 18. Event Bus Responsibilities

The Event Bus is responsible for:

* Publishing
* Routing
* Persistence (if configured)
* Retry policies
* Replay support
* Monitoring
* Dead-letter handling

The Event Bus should not execute business logic.

---

# 19. Observability

Every event should emit metrics.

Examples:

* Publish latency
* Processing latency
* Retry count
* Consumer failures
* Queue depth
* Throughput

Events should also produce structured logs with correlation IDs.

---

# 20. Event Evolution

When introducing a new event:

1. Define the schema.
2. Assign a version.
3. Document the payload.
4. Add consumer tests.
5. Maintain backward compatibility whenever practical.

---

# 21. Example Flow

```text
Telegram Plugin
        │
        ▼
finance.expense.created
        │
        ▼
Finance Module
        │
        ├────────► finance.budget.updated
        │
        ├────────► analytics.report.updated
        │
        ├────────► memory.financial.updated
        │
        └────────► notification.generated
```

Each module reacts independently, without knowing about the others.

---

# 22. Guiding Principles

* Events describe facts, not commands.
* Events are immutable.
* Events are versioned.
* Events are replayable.
* Consumers are independent.
* Producers know nothing about consumers.

> **The Event Model is the universal language of Personal OS. Every plugin, module, workflow, and agent communicates through this shared contract.**
