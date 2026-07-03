# DECISION_ENGINE.md

> Defines the architecture, reasoning framework, decision lifecycle, and explainability model for Personal OS.

---

# 1. Purpose

The Decision Engine is the core intelligence layer of Personal OS.

Its purpose is not to answer questions.

Its purpose is to help users make **better decisions** using:

* Long-term memory
* Current context
* Business rules
* AI reasoning
* External information
* User preferences

Every recommendation should be:

* Explainable
* Reproducible
* Auditable
* Context-aware

---

# 2. What is a Decision?

A decision is a recommendation produced after evaluating multiple sources of evidence.

Examples:

Financial

* Buy a car
* Purchase a house
* Invest bonus
* Increase SIP

Career

* Switch jobs
* Accept an offer
* Learn a new technology

Health

* Reduce weight
* Improve sleep
* Start a workout plan

Lifestyle

* Plan vacation
* Buy a laptop
* Cancel subscriptions

---

# 3. Decision Architecture

```text
                    User Request
                         │
                         ▼
                  Planner Agent
                         │
                         ▼
               Decision Orchestrator
                         │
      ┌──────────────────┼──────────────────┐
      ▼                  ▼                  ▼
  Memory Runtime     Domain Agents     External Tools
      │                  │                  │
      └──────────────────┼──────────────────┘
                         ▼
                 Context Builder
                         │
                         ▼
                 Rule Evaluation
                         │
                         ▼
                  AI Reasoning
                         │
                         ▼
                Decision Composer
                         │
                         ▼
                 Decision Response
                         │
                         ▼
                Decision Memory Store
```

---

# 4. Decision Lifecycle

Every decision follows the same lifecycle.

```text
User Intent

↓

Collect Context

↓

Retrieve Memories

↓

Execute Tools

↓

Evaluate Rules

↓

AI Reasoning

↓

Generate Recommendation

↓

Explain Recommendation

↓

Store Decision

↓

Learn From Outcome
```

---

# 5. Decision Inputs

A decision may use:

## User Context

* Current request
* Goals
* Preferences
* Constraints

---

## Long-Term Memory

* Previous decisions
* Habits
* Financial history
* Health history

---

## Domain Modules

Finance

Health

Goals

Shopping

Calendar

Knowledge

---

## External Sources

Search

Weather

Maps

Market Data

Calendar

Email

Documents

---

## Rules

Business rules

Personal rules

Compliance rules

Safety rules

---

# 6. Context Builder

The Context Builder is responsible for assembling only the information required for the current decision.

Example

User asks:

> Should I buy a Fronx?

Relevant context

✓ Income

✓ Savings

✓ Emergency Fund

✓ Existing Car

✓ Monthly Expenses

✓ Investment Goals

Ignored

✗ Workout history

✗ Browser bookmarks

✗ Movie preferences

Context should be minimal but sufficient.

---

# 7. Rule Engine

Rules are deterministic.

Examples

```text
Emergency Fund < 6 months

↓

High Risk
```

```text
Debt Ratio > 40%

↓

Avoid New Loan
```

Rules execute before AI reasoning.

LLMs should not replace deterministic calculations.

---

# 8. AI Reasoning

After rules complete, the AI evaluates:

Trade-offs

Risks

Benefits

Alternatives

Long-term consequences

AI should never ignore rule violations.

---

# 9. Decision Output

Every decision returns a structured response.

```json
{
  "decisionId": "dec_001",
  "status": "recommended",
  "confidence": 0.89,
  "summary": "...",
  "recommendation": "...",
  "reasoning": [],
  "assumptions": [],
  "alternatives": [],
  "risks": [],
  "nextActions": []
}
```

---

# 10. Explainability

Every recommendation must answer:

Why?

Why not?

What assumptions?

What evidence?

What memories?

What rules?

Example

Recommendation

Buy Fronx Delta

Evidence

* Fits budget
* Emergency fund maintained
* Lowest ownership cost

Alternatives

* Delay purchase
* Buy used

---

# 11. Confidence

Confidence is calculated using:

* Data completeness
* Rule certainty
* Memory quality
* AI confidence
* External data reliability

Low confidence recommendations should encourage users to gather more information.

---

# 12. Decision Memory

Every important decision is stored.

Example

```json
{
  "decision": "Bought Fronx",
  "reason": "...",
  "confidence": 0.91,
  "alternatives": [
    "Toyota Urban Cruiser"
  ],
  "outcome": "Pending"
}
```

Months later

Outcome

Satisfied

↓

Future recommendations improve.

---

# 13. Feedback Loop

The engine continuously learns.

```text
Decision

↓

User Action

↓

Outcome

↓

Feedback

↓

Memory Updated

↓

Future Decisions Improve
```

Learning is based on user outcomes, not blind reinforcement.

---

# 14. Decision Categories

Financial

Career

Health

Education

Travel

Shopping

Relationships

Time Management

Knowledge

Life Planning

Each category may define its own rules and scoring.

---

# 15. Safety

The Decision Engine should:

* Highlight uncertainty.
* Distinguish facts from inferences.
* Avoid presenting speculation as certainty.
* Encourage professional advice for medical, legal, or financial matters when appropriate.

Recommendations support the user—they do not replace expert judgment.

---

# 16. Extensibility

New decision domains should require:

1. A new module (if needed).
2. Domain-specific rules.
3. One or more specialized agents.
4. Optional plugins.
5. Registration with the Planner Agent.

Existing domains should not require modification.

---

# 17. Example Flow

User

> Should I buy this house?

Decision Engine

↓

Retrieve Financial Memory

↓

Retrieve Goals

↓

Calculate Cash Flow

↓

Evaluate Loan Rules

↓

Search Market Data

↓

AI Comparison

↓

Generate Recommendation

↓

Store Decision

↓

Explain Reasoning

---

# 18. Future Enhancements

* Multi-objective optimization
* What-if scenario simulation
* Monte Carlo financial projections
* Goal conflict analysis
* Personal value weighting
* Collaborative decisions (family mode)
* Temporal reasoning ("If I wait 12 months...")

---

# 19. Success Metrics

The Decision Engine succeeds when it:

* Produces recommendations that are understandable.
* Cites the evidence behind every recommendation.
* Improves as more user context becomes available.
* Learns from outcomes without compromising user privacy.
* Allows new domains to be added without redesigning the core engine.

---

# 20. Guiding Principle

> **The Decision Engine exists to augment human judgment—not replace it.**

Every recommendation should combine deterministic rules, relevant memories, trusted data, and AI reasoning to help users make informed, transparent, and explainable decisions.
