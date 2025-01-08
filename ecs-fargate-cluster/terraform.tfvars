# Purpose: Define the variables that will be used in the terraform configuration
#Common Terraform variables acros all environments
AWS_REGION               = "us-east-1"
terraform_s3_bucket      = "conversion-app-tf-state-bucket"
dynamodb_lock_table_name = "ecs-fargate-tf-state-lock"
backend_key              = "conversion-app.tfstate"
subnet_count             = 2
subnet_mask              = 8
app_count                = 2

# Production environment Specific variables
prod_vpc_cidr_block  = "10.0.0.0/16"
prod_ecs_task_cpu    = 2048
prod_ecs_task_memory = 4096
prod_container_port  = 8080
prod_ecs_host_port   = 8080

# Staging environment Specific variables
stg_vpc_cidr_block  = "10.1.0.0/16"
stg_ecs_task_cpu    = 1024
stg_ecs_task_memory = 2048
stg_container_port  = 8080
stg_ecs_host_port   = 8080

# Development environment Specific variables
dev_vpc_cidr_block  = "10.2.0.0/16"
dev_ecs_task_cpu    = 1024
dev_ecs_task_memory = 2048
dev_container_port  = 8080
dev_ecs_host_port   = 8080

#Applicaiton related variables
application_image_name    = "conversion-app"
application_image_version = "latest"
