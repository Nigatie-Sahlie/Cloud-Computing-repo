#!/bin/bash
set -e

# --- Config ---
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="425124975916"
ECR_REPO="my-app"
CLUSTER="my-ecs-cluster"
SERVICE="my-ecs-service"
IMAGE_TAG=$(git rev-parse --short HEAD)
ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"

echo "==> Logging in to ECR"
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ECR_URI"

echo "==> Building image"
docker build -t "$ECR_REPO" -f docker/Dockerfile .

echo "==> Tagging image"
docker tag "$ECR_REPO":latest "$ECR_URI":"$IMAGE_TAG"
docker tag "$ECR_REPO":latest "$ECR_URI":latest

echo "==> Pushing image"
docker push "$ECR_URI":"$IMAGE_TAG"
docker push "$ECR_URI":latest

echo "==> Deploying to ECS (force new deployment)"
aws ecs update-service \
  --cluster "$CLUSTER" \
  --service "$SERVICE" \
  --force-new-deployment \
  --region "$AWS_REGION"

echo "==> Deploy triggered. Check ECS console or run scripts/health-check.sh"