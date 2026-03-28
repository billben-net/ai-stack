# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal AI stack that runs LiteLLM proxy, Open WebUI, and Apache Tika as containerized services.

## Commands

All stack operations use the Makefile, which wraps `uv run dotenv run -- docker-compose`:

```bash
make up          # start all services
make down        # stop all services
make restart     # stop then start
make rebuild     # pull latest images and force-recreate containers
make pull        # pull latest images only
make logs        # tail all logs (use SVC=<name> for one service)
make ps          # show running containers
make clean       # stop and remove containers + orphans
```

### First-time setup
Copy `.env.example` to `.env` and fill in API keys before running `make up`.

### Python dependency management
```bash
uv add <package>          # add a dependency
uv sync                   # install from lockfile
```

## Architecture

- **docker-compose.yaml** — three services:
  - `litellm-proxy` (port 4000): unified LLM gateway; model list in `litellm-proxy/config.yaml`
  - `open-webui` (port 3000): chat UI backed by a named Docker volume (`open-webui`)
  - `tika` (port 9998): Apache Tika document processing
- **scripts/** — standalone helper scripts (e.g., OAuth refresh token retrieval).

## Conventions

- The container engine is **Podman**, but **docker-compose** is the compose tool (not podman-compose).
- Use **uv** for Python package management (not pip).
- Environment variables for API keys live in `.env` (gitignored) and are injected via `dotenv run`.
