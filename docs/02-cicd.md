# Phase 2: CI/CD with GitHub Actions

## What I Built
- A centralized reusable workflow repo (`platform-workflows-lab`)
- A developer app repo that calls the reusable workflow in 10 lines

## Key Learnings
- `workflow_call` is the key to reusable pipelines
- Developers only write 10 lines; platform team maintains complex logic
- Version workflows with tags (v1, v2) to prevent breaking changes
- Use GitHub OIDC for secret management — no long-lived credentials

## Screenshots
![GitHub Actions Run](../screenshots/github-actions.png)