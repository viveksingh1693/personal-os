# Contributing

Thank you for helping build the Personal OS CLI.

## Development Setup

```bash
uv sync --dev
```

## Quality Checks

Before opening a pull request, run:

```bash
uv run ruff check .
uv run black --check .
uv run mypy personal_os_cli
uv run pytest
```

## Architecture

The CLI is organized around clean architecture boundaries:

- CLI command modules handle command-line input and presentation.
- Application services own workflow and validation behavior.
- Generators render templates and delegate file writes.
- Utilities remain small, typed, and dependency-light.
