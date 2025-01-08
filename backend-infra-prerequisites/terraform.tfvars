# Purpose: Define the variables that will be used in the terraform configuration
#Common Terraform variables acros all environments
AWS_REGION               = "us-east-1"
terraform_s3_bucket      = "conversion-app-tf-state-bucket"
dynamodb_lock_table_name = "ecs-fargate-tf-state-lock"