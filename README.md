# Cloud Computing & DevOps Portfolio

[![GitHub](https://img.shields.io/badge/GitHub-Nigatie--Sahlie-181717?logo=github)](https://github.com/Nigatie-Sahlie)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Sanige-0A66C2?logo=linkedin)](https://www.linkedin.com/in/sanige)

Practical cloud computing and DevOps projects focused on containerization, CI/CD automation, AWS infrastructure, and deployment workflows.

## Featured Projects

### DevOps CI/CD to AWS ECS Fargate

A containerized Node.js application deployed to Amazon ECS using AWS Fargate, Amazon ECR, an Application Load Balancer, and an automated GitHub Actions pipeline.

- Docker and ECS task definition configuration
- Automated build, image publication, and deployment
- Health checks and deployment verification
- Scripts for startup, cleanup, and AWS resource cost control
- Architecture documentation and project report

[View project](./DevOps/DevOps-final)

### Static Application Deployment to AWS S3

A Python application with automated testing and deployment to Amazon S3 through GitHub Actions.

- Unit testing with pytest
- Linting with flake8
- Automated CI and S3 deployment workflows
- Static web interface
- AWS bucket policy configuration

[View project](./DevOps/DevOps-1)

### Additional Cloud and Container Exercises

- `Docker-container/` — Docker demos and multi-stage Go image builds
- `DevOps/calculator-app/` — Python application and PostgreSQL integration exercise
- `Others/` — Supporting project files and documentation

## Technology

| Area | Technologies |
|---|---|
| Cloud | AWS, S3, ECR, ECS, Fargate, Application Load Balancer |
| Containers | Docker, multi-stage builds |
| CI/CD | GitHub Actions |
| Languages | Python, JavaScript, Go |
| Frameworks | Flask, Express.js |
| Databases | PostgreSQL |
| Testing | pytest |

## Repository Structure

```text
Cloud-Computing-repo/
├── DevOps/
│   ├── DevOps-1/       # Python CI/CD and AWS S3 deployment
│   ├── DevOps-final/   # Node.js CI/CD and AWS ECS Fargate deployment
│   └── calculator-app/ # Python and PostgreSQL exercise
├── Docker-container/   # Docker demonstrations and image optimization
├── Others/             # Supporting files and reports
├── .github/workflows/  # CI/CD pipeline definitions
└── README.md
```

## Getting Started

Clone the repository:

```bash
git clone https://github.com/Nigatie-Sahlie/Cloud-Computing-repo.git
cd Cloud-Computing-repo
```

Each project includes its own dependencies and setup instructions. AWS deployments require credentials and an appropriately configured AWS account.

## AWS Cost Management

AWS resources in the final project can be paused or removed using the provided scripts.

```bash
./DevOps/DevOps-final/scripts/cleanup.sh
./DevOps/DevOps-final/scripts/StartUp.sh
```

## About

**Nigatie Sahlie** is a software engineering and cloud computing practitioner focused on building reliable, automated, and maintainable deployment solutions.

- [GitHub](https://github.com/Nigatie-Sahlie)
- [LinkedIn](https://www.linkedin.com/in/sanige)
