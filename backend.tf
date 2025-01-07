# Purpose: This file is used to configure the backend for the terraform state file.
# The backend is the location where the state file is stored. In this case, the state file is stored in an S3 bucket.
# Locking is enabled for each workspace to prevent concurrent writes to the state file.
# S3 bucket will also isolate the state files for each workspace.
terraform {
  backend "s3" {
    bucket  = var.s3_bucket
    region  = var.AWS_REGION
    key     = var.backend_key
    encrypt = true
    dynamodb_table = "${terraform.workspace}-ecs-fargate-tf-lock"
  }

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}