# DevOps Final Project — CI/CD Pipeline to AWS ECS Fargate

A Node.js/Express app deployed to **AWS ECS Fargate** using a fully automated **GitHub Actions CI/CD pipeline**, with traffic served through an **Application Load Balancer**.

## Architecture

```
GitHub Push → GitHub Actions → Build Docker Image → Push to ECR
    → Update ECS Task Definition → Deploy to ECS Fargate
    → ALB routes traffic → Running Container
```

## Tech Stack

- **App:** Node.js, Express
- **Containerization:** Docker
- **Registry:** Amazon ECR
- **Orchestration:** Amazon ECS (Fargate)
- **Load Balancing:** Application Load Balancer (ALB)
- **CI/CD:** GitHub Actions
- **IaC/Config:** ECS Task Definition (JSON)

## Project Structure

```
├── app/                  # Application source code
├── docker/               # Dockerfile
├── aws/                  # ECS task definition
├── scripts/              # Deployment & maintenance scripts
│   ├── deploy.sh         # Build, push, and deploy latest code
│   ├── health-check.sh   # Verify service & app health
│   ├── startup.sh        # Recreate ALB/target group and resume service
│   └── cleanup.sh        # Tear down billed resources
├── .github/workflows/    # CI/CD pipeline definition
└── docs/                 # Project report & presentation
```

## Setup

1. Configure AWS credentials as GitHub Secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. Push to `main` — the pipeline builds, pushes, and deploys automatically.

## Scripts

| Script | Purpose |
|---|---|
| `scripts/deploy.sh` | Manual build/push/deploy |
| `scripts/health-check.sh` | Check ECS service & app status |
| `scripts/startup.sh` | Recreate ALB and resume service after cleanup |
| `scripts/cleanup.sh` | Scale down & delete ALB to pause AWS billing |

## Notes

This is a learning/practice project. AWS resources are paused (not deleted) between sessions using `cleanup.sh` and resumed with `startup.sh` to minimize cost.