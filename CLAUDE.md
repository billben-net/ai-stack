# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal AI stack that runs LiteLLM proxy, Open WebUI, and Apache Tika as containerized services, with custom Open WebUI tools (Python) for integrations like Google Calendar.

## Commands

### Start/stop the stack
```bash
uv run dotenv run -- docker-compose up -d
uv run dotenv run -- docker-compose down
```
The `dotenv run` wrapper loads `.env` into the environment so container services receive API keys. Copy `.env.example` to `.env` and fill in keys before first run.

### Python dependency management
```bash
uv add <package>          # add a dependency
uv sync                   # install from lockfile
```

### OAuth token helper
```bash
GOOGLE_OAUTH_KEY='<json>' uv run python scripts/get_refresh_token.py
```

## Architecture

- **docker-compose.yaml** — defines three services:
  - `litellm-proxy` (port 4000): unified LLM gateway; model list in `litellm-proxy/config.yaml`
  - `open-webui` (port 3000): chat UI backed by a named Docker volume (`open-webui`)
  - `tika` (port 9998): Apache Tika document processing
- **open_webui_tools/** — Python tool classes that Open WebUI loads at runtime. Each file follows the Open WebUI tool spec (module-level docstring with metadata, a `Tools` class with callable methods). Currently contains `gcal.py` for Google Calendar.
- **scripts/** — standalone helper scripts (e.g., OAuth refresh token retrieval).

## Conventions

- Use **Podman** instead of Docker for container commands unless told otherwise.
- Use **uv** for Python package management (not pip).
- Environment variables for API keys live in `.env` (gitignored) and are injected via `dotenv run`.
