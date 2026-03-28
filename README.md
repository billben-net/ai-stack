# ai-stack

A personal AI stack running LiteLLM proxy, Open WebUI, and Apache Tika as containerized services.

## Quick Start

1. **Create external resources** (one-time):
   ```bash
   podman network create ai-stack_default
   podman volume create open-webui
   ```

2. **Set up environment**: Copy `.env.example` to `.env` and fill in your API keys.

3. **Launch services**:
   ```bash
   make up
   ```

## Services

| Service | Port | Description |
|---------|------|-------------|
| `litellm-proxy` | 4000 | Unified LLM gateway (OpenAI, Anthropic, Google) |
| `open-webui` | 3000 | Chat UI |
| `tika` | 9998 | Document processing |

## Make Targets

```
make up        # start all services
make down      # stop all services
make restart   # stop then start
make rebuild   # pull latest images and force-recreate
make logs      # tail logs (SVC=<name> for one service)
make ps        # show running containers
make clean     # stop and remove containers + orphans
```

## Requirements

- Python 3.11+
- Podman
- docker-compose
- uv
