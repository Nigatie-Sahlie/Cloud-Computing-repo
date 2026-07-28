# Cloud Computing Repo

Practice repository for cloud computing and DevOps: CI/CD pipelines, AWS deployments (S3, ECR, ECS), and infrastructure automation.

## Projects

### `DevOps/DevOps-1` — Python CI/CD to S3
A simple Python app (basic math operations: add, subtract, multiply, divide) with unit tests, deployed as a static site to AWS S3.

- **App:** `app.py`
- **Tests:** `tests/test_app.py` (pytest)
- **Dependencies:** `requirements.txt`
- **Static site:** `index.html`
- **Workflows:**
  - `test.yml` — runs pytest + flake8 on push
  - `deploy.yml` — syncs files to S3 on push

### `DevOps/DevOps-final` — CI/CD to AWS ECS Fargate
A Node.js/Express app deployed to AWS ECS Fargate via Docker, with an Application Load Balancer.

- **App:** `app/app.js`
- **Container:** `docker/Dockerfile`
- **Infra config:** `aws/task-definition.json`
- **Scripts:** `scripts/` (deploy, health-check, startup, cleanup)
- **Docs:** `docs/` (report, presentation)
- **Workflow:** `ci-cd.yml` — builds Docker image, pushes to ECR, deploys to ECS

### `Others/`
Miscellaneous project files (e.g. `CloudGallery_Project_1.pdf`).

## CI/CD Overview

| Workflow | Triggers on | Purpose |
|---|---|---|
| `test.yml` | push/PR to `main` | Test & lint `DevOps-1` |
| `deploy.yml` | push to `main` (html/css/js) | Deploy `DevOps-1` to S3 |
| `ci-cd.yml` | push to `main` | Build & deploy `DevOps-final` to ECS |

## Setup

1. Add AWS credentials as GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. Push to `main` to trigger the relevant pipeline.

## Status

Learning/practice repo — AWS resources are paused between sessions to control cost (see `DevOps-final/scripts/cleanup.sh` and `startup.sh`).