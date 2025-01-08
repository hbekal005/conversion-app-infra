variable "AWS_REGION" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "terraform_s3_bucket" {
  description = "The name of the S3 bucket to store the Terraform state file"
  type        = string
}

variable "dynamodb_lock_table_name" {
  description = "The name of the DynamoDB table to store the lock for the Terraform state file"
  type        = string
}


variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS access key ID"
  type        = string

}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS secret access key"
  type        = string

}



