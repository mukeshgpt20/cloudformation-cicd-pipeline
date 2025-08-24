#!/bin/bash

set -e

BOOTSTRAP_STACK_NAME="cf-cicd-bootstrap"
PIPELINE_STACK_NAME="cf-cicd-main"

echo "Deploying bootstrap stack..."
aws cloudformation deploy \
  --stack-name $BOOTSTRAP_STACK_NAME \
  --template-file bootstrap.yaml \
  --capabilities CAPABILITY_NAMED_IAM

ARTIFACT_BUCKET=$(aws cloudformation describe-stacks --stack-name $BOOTSTRAP_STACK_NAME \
  --query "Stacks[0].Outputs[?OutputKey=='ArtifactBucketName'].OutputValue" --output text)
PIPELINE_ROLE_ARN=$(aws cloudformation describe-stacks --stack-name $BOOTSTRAP_STACK_NAME \
  --query "Stacks[0].Outputs[?OutputKey=='PipelineRoleArn'].OutputValue" --output text)
REPO_NAME=$(aws cloudformation describe-stacks --stack-name $BOOTSTRAP_STACK_NAME \
  --query "Stacks[0].Outputs[?OutputKey=='CodeCommitRepoName'].OutputValue" --output text)

echo "Deploying pipeline stack..."
aws cloudformation deploy \
  --stack-name $PIPELINE_STACK_NAME \
  --template-file pipeline.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    CodeCommitRepoName=$REPO_NAME \
    ArtifactBucketName=$ARTIFACT_BUCKET \
    PipelineRoleArn=$PIPELINE_ROLE_ARN
