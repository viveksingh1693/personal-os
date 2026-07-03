# MODULE_SDK.md

> Defines the lifecycle, contracts, ownership rules, and development standards for every business module in Personal OS.

---

# 1. Purpose

Modules represent business capabilities.

Examples:

* Finance
* Health
* Shopping
* Goals
* Calendar
* Knowledge
* Journal
* Travel
* Career

A module owns:

* Business Rules
* Domain Models
* APIs
* Events
* AI Prompts
* Workflows
* Configuration

Modules should remain completely independent.

---

# 2. Responsibilities

Every module is responsible for:

✅ Owning its data

✅ Publishing domain events

✅ Providing APIs

✅ Validating business rules

✅ Exposing AI prompts

✅ Registering workflows

Modules are NOT responsible for:

❌ External integrations

❌ Long-term memory

❌ Scheduling

❌ Notifications

❌ Agent orchestration

---

# 3. Module Architecture

```text
Finance Module

├── api/
├── application/
├── domain/
├── infrastructure/
├── repository/
├── workflows/
├── prompts/
├── events/
├── configuration/
└── tests/
```

Every module follows exactly the same structure.

---

# 4. Module Lifecycle

```text
Register

↓

Initialize

↓

Load Configuration

↓

Subscribe Events

↓

Expose APIs

↓

Ready

↓

Shutdown
```

---

# 5. Module Interface

Every module implements the same contract.

```java
public interface Module {

    ModuleMetadata metadata();

    void initialize();

    void start();

    void stop();

    List<EventType> subscribedEvents();

    List<ApiDefinition> apis();

}
```

The implementation language may change.

The contract should not.

---

# 6. Module Metadata

Every module publishes metadata.

Example

```yaml
id: finance

name: Finance

version: 1.0.0

owner: core

dependencies:

- memory

- notification
```

---

# 7. Module Boundaries

Modules own their data.

Example

Finance owns

* Expense
* Budget
* Investment
* Loan

Health owns

* Workout
* Meal
* Sleep

Shopping owns

* Wishlist
* Purchase
* Price Watch

No module may modify another module's entities directly.

---

# 8. Communication

Modules communicate ONLY through:

* Events
* Public APIs

Never through direct repository access.

Correct

```text
Expense Created

↓

Finance Event

↓

Goals Module
```

Incorrect

```text
Finance Repository

↓

Health Repository
```

---

# 9. Event Ownership

Every module publishes its own events.

Example

Finance

```text
finance.expense.created

finance.expense.deleted

finance.budget.updated
```

Health

```text
health.workout.logged

health.sleep.recorded
```

Shopping

```text
shopping.purchase.created
```

Modules subscribe only to events they need.

---

# 10. API Exposure

Every module exposes APIs.

Example

Finance

```text
GET /expenses

POST /expenses

GET /budget

GET /reports
```

Health

```text
GET /workouts

POST /meal

GET /sleep
```

Modules never expose internal repositories.

---

# 11. AI Integration

Each module owns its prompts.

Example

```text
modules/

finance/

prompts/

categorize_expense.md

monthly_review.md

purchase_advice.md
```

Prompts belong to the module—not the agent.

---

# 12. Workflow Integration

Modules may register workflows.

Example

Finance

* Monthly Report

* Budget Reminder

* Subscription Review

Health

* Daily Workout Reminder

* Sleep Analysis

---

# 13. Configuration

Every module owns its own configuration.

Example

```yaml
finance:

currency: INR

budgetDay: 1

health:

stepGoal: 10000
```

Configuration must support environment overrides.

---

# 14. Health Check

Every module exposes health information.

Example

```json
{
  "module":"finance",
  "status":"UP"
}
```

The runtime uses this for monitoring.

---

# 15. Versioning

Modules use Semantic Versioning.

Breaking API changes require a major version increase.

---

# 16. Testing Requirements

Every module includes

* Unit Tests
* Integration Tests
* Event Tests
* API Tests
* Workflow Tests

Business rules should have high test coverage.

---

# 17. Extensibility

Adding a new module requires:

1. Implement Module interface
2. Register module
3. Register events
4. Register APIs
5. Register prompts
6. Register workflows
7. Add documentation

Existing modules should not require modification.

---

# 18. Future Modules

Planned modules include:

* Finance
* Health
* Goals
* Shopping
* Calendar
* Knowledge
* Journal
* Travel
* Career
* Learning
* Property
* Vehicle
* Insurance
* Subscription
* Smart Home

---

# 19. Success Criteria

A module is well-designed if:

* It owns its domain.
* It has no hidden dependencies.
* It communicates through events.
* It can be developed independently.
* It can be tested independently.
* It can be deployed independently in the future.

---

# 20. Guiding Principle

> **Modules own business capabilities. They should encapsulate domain logic, expose stable APIs, publish meaningful events, and remain independent of implementation details in other modules.**
