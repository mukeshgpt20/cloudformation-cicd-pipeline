# AWS CloudFormation CI/CD Pipeline

This project sets up a **CI/CD pipeline using AWS CloudFormation** that provisions AWS infrastructure using templates managed in **CodeCommit**. The pipeline is built using **CodePipeline**, **CodeBuild**, and **CodeCommit**, and includes steps for validating and deploying your CloudFormation templates.

---

## 📌 Features

- 🏗️ Bootstraps the required AWS infrastructure:
  - S3 bucket for storing pipeline artifacts
  - CodeCommit repository to store CloudFormation templates
  - Unified IAM role for CodePipeline and CodeBuild

- 🚀 Creates a CI/CD pipeline that:
  1. Pulls templates from CodeCommit
  2. Validates templates using `cfn-lint` and `aws cloudformation validate-template`
  3. Waits for manual approval
  4. Deploys the root `template.yaml` and any nested stacks

---

## 📁 File Structure
```
cloudformation-cicd-pipeline/
│
├── bootstrap.yaml # Creates S3 bucket, CodeCommit repo, IAM roles
├── pipeline.yaml # Defines CodePipeline and CodeBuild project
├── deploy.sh # Shell script to deploy both stacks
└── README.md # You're reading it!

```