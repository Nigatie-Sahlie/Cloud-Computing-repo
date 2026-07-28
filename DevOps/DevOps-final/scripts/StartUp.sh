#!/bin/bash
# Recreates ALB + target group + listener, attaches to ECS service,
# and scales it back up. Run after cleanup.sh to resume practice.
set -e

AWS_REGION="us-east-1"
VPC_ID="vpc-0b67b5473091d78e5"
SUBNETS="subnet-0f04fee82dc1f1252 subnet-0d648f388526cc379"
SG_ID="sg-09c9687dbba4812bd"
CLUSTER="my-ecs-cluster"
SERVICE="my-ecs-service"
ALB_NAME="my-app-alb"
TG_NAME="my-app-tg"
CONTAINER_NAME="app"
CONTAINER_PORT=3000

echo "==> Creating target group"
TG_ARN=$(aws elbv2 create-target-group \
  --name "$TG_NAME" \
  --protocol HTTP --port $CONTAINER_PORT \
  --vpc-id "$VPC_ID" \
  --target-type ip \
  --health-check-path /health \
  --region "$AWS_REGION" \
  --query "TargetGroups[0].TargetGroupArn" --output text)
echo "Target group: $TG_ARN"

echo "==> Creating load balancer"
ALB_ARN=$(aws elbv2 create-load-balancer \
  --name "$ALB_NAME" \
  --subnets $SUBNETS \
  --security-groups "$SG_ID" \
  --scheme internet-facing --type application \
  --region "$AWS_REGION" \
  --query "LoadBalancers[0].LoadBalancerArn" --output text)
echo "Load balancer: $ALB_ARN"

echo "==> Waiting for ALB to become active"
aws elbv2 wait load-balancer-available --load-balancer-arns "$ALB_ARN" --region "$AWS_REGION"

echo "==> Creating listener"
aws elbv2 create-listener \
  --load-balancer-arn "$ALB_ARN" \
  --protocol HTTP --port 80 \
  --default-actions Type=forward,TargetGroupArn="$TG_ARN" \
  --region "$AWS_REGION"

echo "==> Attaching target group to ECS service and scaling to 1"
aws ecs update-service \
  --cluster "$CLUSTER" \
  --service "$SERVICE" \
  --desired-count 1 \
  --load-balancers targetGroupArn="$TG_ARN",containerName="$CONTAINER_NAME",containerPort=$CONTAINER_PORT \
  --force-new-deployment \
  --region "$AWS_REGION"

ALB_DNS=$(aws elbv2 describe-load-balancers --load-balancer-arns "$ALB_ARN" \
  --region "$AWS_REGION" --query "LoadBalancers[0].DNSName" --output text)

echo "==> Done. App will be live at http://$ALB_DNS in ~1-2 minutes"