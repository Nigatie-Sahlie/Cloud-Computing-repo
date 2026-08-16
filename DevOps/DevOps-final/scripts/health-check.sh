#!/bin/bash
set -e

# --- Config ---
AWS_REGION="us-east-1"
CLUSTER="my-ecs-cluster"
SERVICE="my-ecs-service"
ALB_DNS="dev-ops-alb-998634647.us-east-1.elb.amazonaws.com"

echo "==> ECS service status"
aws ecs describe-services \
  --cluster "$CLUSTER" \
  --services "$SERVICE" \
  --region "$AWS_REGION" \
  --query "services[0].{desired:desiredCount,running:runningCount,status:status}" \
  --output table

echo "==> App health via ALB"
if curl -sf "http://${ALB_DNS}/health" -o /tmp/health.out; then
  echo "Health check: OK"
  cat /tmp/health.out
else
  echo "Health check: FAILED (app not responding)"    
  exit 1
fi

echo "==> Root endpoint response"
curl -s "http://${ALB_DNS}/"
echo