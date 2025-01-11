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

variable "backend_key" {
  description = "The key for the Terraform state file in S3"
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

variable "subnet_count" {
  description = "The number of subnets to create"
  type        = number
}

variable "subnet_mask" {
  description = "The subnet mask for the subnets"
  type        = number
  default     = 8
}

variable "app_count" {
  description = "The number of applications to deploy"
  type        = number
  default     = 2
}

variable "all_cidr_block" {
  description = "Covers all the CIDR blocks"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_cidr_blocks" {
  description = "CIDR Block for the  VPC"
  type        = map(string)
}

variable "subnet_01_cidr_blocks" {
  description = "Subnet 01 CIDR Block for the  VPC"
  type        = map(string)
}

variable "subnet_02_cidr_blocks" {
  description = "Subnet 02 CIDR Block for the  VPC"
  type        = map(string)
}

variable "ecs_task_cpu" {
  description = "The number of CPU units for the  ECS task"
  type        = map(number)
}

variable "ecs_task_memory" {
  description = "The amount of memory (in MiB) for the  ECS task"
  type        = map(number)
}

variable "container_port" {
  description = "Container Port for application"
  type        = map(number)
}

variable "ecs_host_port" {
  description = "EC2 HOST Port for  ECS"
  type        = map(number)
}

# Application Images Variables
variable "application_image_name" {
  description = "The Docker image for the ECS task"
  type        = string
}

variable "application_image_version" {
  description = "The version of the Docker image for the ECS task"
  type        = string
  default     = "latest"
}







