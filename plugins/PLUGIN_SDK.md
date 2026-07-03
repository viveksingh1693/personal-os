# PLUGIN_SDK.md

> Defines the Plugin SDK, lifecycle, contracts, permissions, and extension model for Personal OS.

---

# 1. Purpose

Plugins are responsible for integrating Personal OS with external systems.

Examples include:

* Telegram
* WhatsApp *(where officially supported)*
* Gmail
* Google Calendar
* Browser Extension
* GitHub
* CSV Import
* PDF Import
* OCR
* Web Crawler *(respecting robots.txt and site terms)*

Plugins **never implement business logic**.

Their responsibility is to:

* Connect
* Authenticate
* Read data
* Normalize data
* Publish events

Everything else belongs elsewhere.

---

# 2. Plugin Architecture

```text
                    Plugin Runtime
                           │
         ┌─────────────────┼──────────────────┐
         │                 │                  │
         ▼                 ▼                  ▼
   Telegram Plugin   Gmail Plugin   Browser Plugin
         │                 │                  │
         └─────────────────┼──────────────────┘
                           │
                           ▼
                Canonical Event Publisher
                           │
                           ▼
                      Event Bus
```

Plugins never communicate with modules directly.

---

# 3. Plugin Lifecycle

```text
Install

↓

Register

↓

Configure

↓

Authenticate

↓

Start

↓

Publish Events

↓

Stop

↓

Uninstall
```

Every plugin follows this lifecycle.

---

# 4. Responsibilities

Plugins are responsible for:

✓ Authentication

✓ Reading external data

✓ Mapping external formats

✓ Publishing canonical events

✓ Health checks

✓ Configuration validation

Plugins are **not** responsible for:

✗ Budget calculations

✗ Decision making

✗ Database updates

✗ AI prompts

✗ Business rules

---

# 5. Plugin Manifest

Every plugin includes a manifest.

Example

```yaml
id: telegram

name: Telegram Plugin

version: 1.0.0

author: Personal OS

permissions:
  - network
  - events.publish

events:
  - message.received

configuration:
  - botToken

capabilities:
  - messaging
```

---

# 6. Plugin Interface

Every plugin implements the same contract.

```java
public interface Plugin {

    PluginMetadata metadata();

    void initialize();

    void start();

    void stop();

    HealthStatus health();

    List<Event> poll();

}
```

Alternative implementations are allowed as long as they satisfy the same contract.

---

# 7. Event Publishing

Plugins publish canonical events only.

Example

```json
{
  "source":"telegram",
  "type":"expense.created",
  "payload":{}
}
```

Plugins must never expose provider-specific payloads outside the Plugin Runtime.

---

# 8. Configuration

Each plugin has isolated configuration.

Example

```yaml
telegram:

  botToken: ****

gmail:

  oauthClientId: ****

browser:

  endpoint: localhost
```

Configuration should come from secure storage or environment variables.

Secrets must never be committed.

---

# 9. Permissions

Plugins declare required permissions.

Example

```yaml
permissions:

- network

- filesystem.read

- notifications.send

- browser.read

- calendar.read
```

Unused permissions should not be granted.

---

# 10. Plugin Registry

The Plugin Runtime maintains a registry.

Responsibilities

* Discovery
* Installation
* Version tracking
* Health monitoring
* Enable / Disable
* Configuration

---

# 11. Plugin States

```text
Installed

↓

Configured

↓

Running

↓

Paused

↓

Stopped

↓

Failed
```

Failures should be isolated to the plugin.

---

# 12. Error Handling

Plugins should never crash the application.

Errors are classified as:

* Authentication Error
* Configuration Error
* Network Error
* Rate Limit
* Permission Error
* Unknown Error

Recoverable failures should support retries with backoff.

---

# 13. Versioning

Plugins follow Semantic Versioning.

Examples

```
1.0.0

1.2.0

2.0.0
```

Breaking changes require a major version increment.

---

# 14. Dependency Rules

Plugins may depend on:

* Plugin SDK
* Shared utilities

Plugins may **not** depend on:

* Finance Module
* Health Module
* Other plugins

All interactions occur through events.

---

# 15. Plugin Categories

Messaging

* Telegram
* WhatsApp

Communication

* Gmail
* Outlook

Productivity

* Calendar
* Notion

Files

* CSV
* PDF
* OCR

Browser

* Chrome
* Firefox

Development

* GitHub
* Jira

Automation

* Home Assistant

---

# 16. Plugin Development Checklist

Every plugin should include:

* Manifest
* Configuration schema
* Authentication
* Event mapping
* Health check
* Tests
* Documentation

---

# 17. Security

Plugins must:

* Store credentials securely
* Request minimum permissions
* Validate incoming data
* Respect provider rate limits
* Avoid logging sensitive information

---

# 18. Testing

Each plugin should have:

* Unit tests
* Integration tests
* Mock provider tests
* Event validation tests

No plugin should require a live third-party service for basic automated testing.

---

# 19. Future Enhancements

Planned capabilities include:

* Plugin Marketplace
* Automatic Updates
* Dependency Resolution
* Sandboxed Execution
* Hot Reloading
* Remote Plugin Registry
* Signed Plugins

---

# 20. Guiding Principle

> **Plugins connect Personal OS to the outside world. They should ingest, normalize, and publish events—nothing more.**
