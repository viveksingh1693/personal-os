# Personal OS CLI

Official command-line interface for creating, validating, and maintaining the
Personal OS platform.

## Status

This package is being built incrementally. The current milestone contains the
project skeleton, package metadata, and the directory layout for future command,
service, generator, template, and test implementations.

## Installation

```bash
uv sync --dev
```

## Development

```bash
uv run personal-os --help
uv run pytest
uv run ruff check .
uv run black --check .
uv run mypy personal_os_cli
```
