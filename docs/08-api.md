# API.md

> Defines the API architecture, standards, conventions, versioning strategy, authentication model, and endpoint contracts for Personal OS.

---

# 1. Purpose

The API layer exposes the capabilities of Personal OS to external clients.

Supported clients include:

* Flutter Mobile App
* Web Application
* Desktop Application
* CLI
* Browser Extension
* Third-party Plugins
* Automation Platforms
* Future Public SDKs

The API layer should remain stable even if the internal architecture evolves.

---

# 2. Design Principles

The API must be:

* Consistent
* Versioned
* Stateless
* Secure
* Observable
* Documented
* Backward compatible whenever practical

---

# 3. API Architecture

```text
                 Clients

        Flutter • Web • CLI

                 │

                 ▼

            API Gateway

                 │

       ┌─────────┼─────────┐

       ▼         ▼         ▼

    Modules   Agents   Workflows

                 │

                 ▼

            Event Bus
```

The API Gateway is the only entry point for clients.

---

# 4. API Versioning

Every endpoint belongs to a version.

Example

```text
/api/v1/...
```

Breaking changes require a new version.

Minor enhancements should remain backward compatible.

---

# 5. Resource-Oriented Design

Resources are nouns.

Examples

```text
/users

/expenses

/budgets

/goals

/memories

/decisions

/workflows

/plugins

/agents
```

Avoid action-oriented endpoints when CRUD semantics are appropriate.

---

# 6. Endpoint Categories

## Core

```text
GET /health

GET /ready

GET /version
```

---

## Finance

```text
GET /expenses

POST /expenses

PUT /expenses/{id}

DELETE /expenses/{id}

GET /budgets

POST /budgets

GET /reports/monthly
```

---

## Memory

```text
GET /memories

POST /memories

GET /memories/{id}

DELETE /memories/{id}

POST /memories/search
```

---

## Decisions

```text
POST /decisions/evaluate

GET /decisions

GET /decisions/{id}

POST /decisions/{id}/feedback
```

---

## Agents

```text
GET /agents

GET /agents/{id}

POST /agents/{id}/execute
```

---

## Plugins

```text
GET /plugins

POST /plugins/install

POST /plugins/{id}/configure

POST /plugins/{id}/enable

POST /plugins/{id}/disable
```

---

## Workflows

```text
GET /workflows

POST /workflows

POST /workflows/{id}/execute

GET /workflows/{id}/history
```

---

# 7. Request Format

All requests use JSON.

Example

```json
{
  "amount": 420,
  "category": "Food",
  "merchant": "Domino's"
}
```

Validation occurs before business logic executes.

---

# 8. Response Format

Every response follows a common envelope.

```json
{
  "success": true,
  "data": {},
  "meta": {
    "requestId": "req_123",
    "timestamp": "2026-07-05T12:00:00Z"
  }
}
```

---

# 9. Error Format

Errors use a consistent structure.

```json
{
  "success": false,
  "error": {
    "code": "FINANCE_001",
    "message": "Budget not found.",
    "details": []
  },
  "meta": {
    "requestId": "req_123"
  }
}
```

Errors should be machine-readable.

---

# 10. Authentication

The API should support:

* Local Authentication
* OAuth 2.0
* API Keys (for integrations)
* Future SSO providers

Authentication is handled at the API Gateway.

Modules should receive an authenticated user context rather than validate tokens themselves.

---

# 11. Authorization

Authorization follows least privilege.

Roles may include:

* Owner
* Family Member (future)
* Read-only
* Plugin
* System

Authorization decisions should be centralized.

---

# 12. Pagination

Collection endpoints support:

```text
?page=1
&pageSize=20
```

Responses include:

* total
* page
* pageSize
* hasNext

Cursor-based pagination may be introduced for large datasets.

---

# 13. Filtering

Example

```text
GET /expenses

?category=Food

&from=2026-07-01

&to=2026-07-31
```

Filtering should be composable and predictable.

---

# 14. Idempotency

Write operations that may be retried should support an `Idempotency-Key` header.

Repeated requests with the same key should produce the same result.

---

# 15. Correlation IDs

Every request receives a Correlation ID.

This ID propagates through:

* API
* Event Bus
* Workflows
* Agents
* Logs

This enables end-to-end tracing.

---

# 16. Rate Limiting

The API Gateway is responsible for:

* Rate limiting
* Request throttling
* Abuse prevention

Modules should not implement rate limiting individually.

---

# 17. Event Integration

Successful state-changing operations publish domain events.

Example

```text
POST /expenses

↓

finance.expense.created
```

The API does not call dependent modules directly.

---

# 18. Observability

Every request records:

* Request ID
* Correlation ID
* User ID
* Endpoint
* Latency
* Status Code

Sensitive data must never be logged.

---

# 19. API Documentation

The platform should expose an OpenAPI specification.

Generated documentation should include:

* Endpoint descriptions
* Request schemas
* Response schemas
* Authentication requirements
* Error codes
* Examples

Documentation should be generated from source where practical.

---

# 20. Future Enhancements

Planned additions include:

* GraphQL gateway
* gRPC for internal communication
* WebSocket subscriptions
* Server-Sent Events
* Batch APIs
* Public SDKs
* API Marketplace

These should extend the existing API rather than replace it.

---

# 21. Guiding Principle

> **The API is the stable public contract of Personal OS. Internal implementations may change, but the API should remain consistent, secure, observable, and developer-friendly.**
