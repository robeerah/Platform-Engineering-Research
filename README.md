# Platform Engineering Lab: Self-Service Developer Platform

A hands-on implementation of a self-service developer platform using **Nomad + Consul**, **GitHub Actions**, **APISIX**, and **Prometheus + Grafana**.

>  This project was completed as part of my Platform Engineering internship research.

##  What This Demonstrates

This lab proves that developers can **deploy, expose, and monitor** their services with minimal platform team intervention — the core philosophy of Platform Engineering.

##  Architecture

```
Developer Code
      ↓
GitHub Actions (CI/CD)
      ↓
┌─────────────────────────────────────────┐
│  Internal CLI Wrapper (JSON → HCL)      │
└─────────────────────────────────────────┘
      ↓
Nomad (Orchestration) + Consul (Discovery)
      ↓
APISIX (API Gateway) → Public URL
      ↓
Prometheus (Auto-Discovery) → Grafana Dashboard
```

##  Project Structure

| Phase | Directory | What You'll Learn |
|-------|-----------|-------------------|
| 1 | `phase-1-nomad-consul/` | Orchestration, service discovery, JSON→HCL templating |
| 2 | `phase-2-github-actions/` | Reusable workflows, central vs. developer repos |
| 3 | `phase-3-apisix/` | Admin API, GitOps routing, rate limiting |
| 4 | `phase-4-monitoring/` | Consul service discovery in Prometheus |
| 5 | `phase-5-golden-path/` | End-to-end automation script |

##  Quick Start

### Prerequisites
```bash
# Install
brew install hashicorp/tap/nomad hashicorp/tap/consul docker docker-compose jq
```

### Run the Full Golden Path
```bash
# Terminal 1: Start Consul
consul agent -dev -ui

# Terminal 2: Start Nomad
nomad agent -dev

# Terminal 3: Start APISIX + Monitoring
cd phase-3-apisix && docker-compose up -d
cd phase-4-monitoring && docker-compose up -d

# Terminal 4: Run the Golden Path
cd phase-5-golden-path
./golden-path.sh app-config.json
```

Then visit:
- **App:** http://127.0.0.1:9080/api/v1/golden-app/test
- **Grafana:** http://localhost:3000 (admin/admin)
- **Prometheus:** http://localhost:9090
- **Consul:** http://localhost:8500
- **Nomad:** http://localhost:4646

##  Deep-Dive Documentation

Each phase has its own documentation with learnings and screenshots:
- [Phase 1: Orchestration](docs/01-orchestration.md)
- [Phase 2: CI/CD](docs/02-cicd.md)
- [Phase 3: API Gateway](docs/03-api-gateway.md)
- [Phase 4: Observability](docs/04-observability.md)
- [Phase 5: Golden Path](docs/05-golden-path.md)

##  Key Learnings

1. **Abstraction is everything** — The JSON→HCL wrapper saves developers from learning Nomad
2. **Reusable workflows** — Developers write 10 lines of CI/CD, not 100
3. **GitOps for gateways** — Routes live in app repos, pushed via Admin API
4. **Auto-discovery** — Prometheus finds services via Consul, no manual config
5. **The Golden Path** — One script deploys, routes, and monitors a service

##  Related Research

See the full research proposal: [Platform Engineering Research Doc](./RESEARCH-DOC.md)

##  Date
October 2026