#!/bin/bash
# Tears down billed resources to pause costs.
# Safe to re-run; ignores errors if a resource is already gone.

AWS_REGION="us-east-1"
CLUSTER="my-ecs-cluster"
SERVICE="my-ecs-service"
ALB_NAME="my-app-alb"
TG_NAME="my-app-tg"

echo "==> Scaling ECS service to 0 (stops Fargate billing)"
aws ecs update-service --cluster "$CLUSTER" --service "$SERVICE" \
  --desired-count 0 --region "$AWS_REGION" || true

echo "==> Finding load balancer"
ALB_ARN=$(aws elbv2 describe-load-balancers --names "$ALB_NAME" \
  --region "$AWS_REGION" --query "LoadBalancers[0].LoadBalancerArn" \
  --output text 2>/dev/null || true)

if [ -n "$ALB_ARN" ] && [ "$ALB_ARN" != "None" ]; then
  echo "==> Deleting load balancer (also removes its listeners)"
  aws elbv2 delete-load-balancer --load-balancer-arn "$ALB_ARN" --region "$AWS_REGION"
else
  echo "No ALB found (already deleted)"
fi

echo "==> Finding target group"
TG_ARN=$(aws elbv2 describe-target-groups --names "$TG_NAME" \
  --region "$AWS_REGION" --query "TargetGroups[0].TargetGroupArn" \
  --output text 2>/dev/null || true)

if [ -n "$TG_ARN" ] && [ "$TG_ARN" != "None" ]; then
  echo "==> Deleting target group"
  aws elbv2 delete-target-group --target-group-arn "$TG_ARN" --region "$AWS_REGION" || true
else
  echo "No target group found (already deleted)"
fi

echo "==> Checking for NAT Gateways (billed hourly if present)"
aws ec2 describe-nat-gateways --region "$AWS_REGION" \
  --query "NatGateways[?State=='available'].{ID:NatGatewayId}" --output table

echo "==> Cleanup done. Cluster, task definition, and ECR repo left intact for reuse."