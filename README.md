# Arma Reforger Dedicated Server (Docker)

This repository provides a lightweight, production-ready Docker image to run an Arma Reforger dedicated server using SteamCMD, with configuration and data volumes mapped from the host.

---
## 📦 Docker Image
[![Build and Push Docker Image to Dockerhub](https://github.com/yeiij/reforger-image/actions/workflows/push-image.yml/badge.svg)](https://github.com/yeiij/reforger-image/actions/workflows/push-image.yml)

---

## 🐳 Docker Compose Setup

You can run the server using the provided `docker-compose.yml`, which maps local folders into the container for configuration, logs, and persistent data.

### Example `docker-compose.yml`

```yaml
services:
  reforger:
    container_name: "reforger"
    image: "yeiij/reforger-image:latest"
    network_mode: "host"
    restart: "unless-stopped"
    volumes:
      - "./config/bans.txt:/server/battleye/bans.txt:ro"
      - "./config/config.json:/server/config.json:ro"
      - "./data:/server/custom"
```

> ℹ️ Local `./data` is mounted to `/server/custom` inside the container, allowing full access to logs, addons, profiles, etc.

---

## 📁 Directory Structure

| Host Path       | Container Path        | Purpose                    |
|-----------------|-----------------------|----------------------------|
| `./config.json` | `/server/config.json` | Server configuration       |
| `./bans.txt`    | `/server/battleye/...`| Optional bans list (read-only) |
| `./data`        | `/server/custom`      | Logs, addons, profiles, saves |

You can inspect or modify files directly from your host system (e.g. `./data/logs`).

---

## 🚀 Usage

### 1. Prepare your config

Create `config/config.json` and optionally `bans.txt`.

### 2. Start the server

```bash
docker compose up -d
```

The server will start and bind the required UDP ports.

### 3. Stop the server

```bash
docker compose down
```

Your data in `./data/` will be preserved.

---

## 🔐 Required Ports

Make sure the following UDP ports are open:

| Port   | Purpose         |
|--------|-----------------|
| 2001   | Game Port       |
| 17777  | Steam Query     |
| 19999  | RCON / backend  |

---

## 🧾 License

This image does not distribute or modify Arma Reforger itself. You must own the game and comply with Bohemia Interactive's license terms.
