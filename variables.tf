variable "AWS_REGION" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment to deploy resources in"
  type        = string
}


variable "s3_bucket" {
  description = "The S3 bucket for Terraform state"
  type        = string
}

variable "backend_key" {
  description = "The key for the Terraform state file in S3"
  type        = string
}

variable "subnet_count" {
    description = "The number of subnets to create"
    type        = number
}

variable "subnet_mask" {
    description = "The subnet mask for the subnets"
    type        = number
    default = 8
}

variable "app_count" {
    description = "The number of applications to deploy"
    type        = number
    default = 2
}

variable "all_cidr_block" {
    description = "Covers all the CIDR blocks"
    type        = string
    default     = "0.0.0.0/0"
}

variable "prod_vpc_cidr_block" {
  description = "CIDR Block for the PROD VPC"
  type        = string
}

variable "stg_vpc_cidr_block" {
  description = "CIDR Block for the STAGE VPC"
  type        = string
}

variable "dev_vpc_cidr_block" {
  description = "CIDR Block for the DEV VPC"
  type        = string
}


variable "application_image_name" {
  description = "The Docker image for the ECS task"
  type        = string
}

variable "application_image_version" {
    description = "The version of the Docker image for the ECS task"
    type        = string
    default     = "latest"
}
variable "dev_ecs_task_cpu" {
  description = "The number of CPU units for the DEV ECS task"
  type        = number
}

variable "dev_ecs_task_memory" {
  description = "The amount of memory (in MiB) for the DEV ECS task"
  type        = number
}

variable "stg_ecs_task_cpu" {
  description = "The number of CPU units for the STAGE ECS task"
  type        = number
}

variable "stg_ecs_task_memory" {
  description = "The amount of memory (in MiB) for the STAGE ECS task"
  type        = number
}

variable "prod_ecs_task_cpu" {
  description = "The number of CPU units for the PROD ECS task"
  type        = number
}

variable "prod_ecs_task_memory" {
  description = "The amount of memory (in MiB) for the PROD ECS task"
  type        = number
}



