Important notes:

Create the S3 bucket separately before launching this stack.

Pass the existing bucket name as the ArtifactBucketName parameter.

Push your template.yaml and nested stacks to your CodeCommit repo.

The pipeline will validate (lint + AWS validation) and deploy your CloudFormation stack.