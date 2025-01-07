# Purpose: Define the variables that will be used in the terraform configuration
#Common Terraform variables acros all environments
AWS_REGION                          = "us-east-1"
s3_bucket                           = "terraform-state-bucket"
backend_key                         = "ecs-fargate/terraform.tfstate"
subnet_count                        = 2
subnet_mask                         = 8
app_count                           = 2

# Production environment Specific variables
environment                         = "prod"
prod_vpc_cidr_block                 = "10.0.0.0/16"
prod_ecs_task_cpu                   = 2048
prod_ecs_task_memory                = 4096

# Staging environment Specific variables
environment                         = "stg"
stg_vpc_cidr_block                  = "10.1.0.0/16"
stg_ecs_task_cpu                    = 1024
stg_ecs_task_memory                 = 2048

# Development environment Specific variables
environment                         = "dev"
dev_vpc_cidr_block                  = "10.2.0.0/16"
dev_ecs_task_cpu                    = 1024
dev_ecs_task_memory                 = 2048

#Applicaiton related variables
application_image_name              = "conversion-app"
application_image_version           = "latest"
