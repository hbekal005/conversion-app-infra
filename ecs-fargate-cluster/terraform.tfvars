# Purpose: Define the variables that will be used in the terraform configuration
#Common Terraform variables acros all environments
AWS_REGION               = "us-east-1"
terraform_s3_bucket      = "conversion-app-tf-state-bucket"
dynamodb_lock_table_name = "ecs-fargate-tf-state-lock"
backend_key              = "conversion-app.tfstate"
subnet_count             = 2
subnet_mask              = 8
app_count                = 2


vpc_cidr_block = {
  prod = "10.0.0.0/16"
  stg  = "10.1.0.0/16"
  dev  = "10.2.0.0/16"
}

ecs_task_cpu = {
  prod = 2048
  stg  = 1024
  dev  = 1024
}

ecs_task_memory = {
  prod = 4096
  stg  = 2048
  dev  = 2048
}

container_port = {
  prod = 80
  stg  = 80
  dev  = 80
}

ecs_host_port = {
  prod = 80
  stg  = 80
  dev  = 80
}

#Applicaiton related variables
application_image_name    = "conversion-app"
application_image_version = "latest"
