# Purpose: Define the variables that will be used in the terraform configuration
#Common Terraform variables acros all environments
AWS_REGION               = "us-east-1"
terraform_s3_bucket      = "conversion-app-tf-state-bucket"
dynamodb_lock_table_name = "ecs-fargate-tf-state-lock"
backend_key              = "conversion-app.tfstate"
subnet_count             = 2
subnet_mask              = 8
app_count                = 2


vpc_cidr_blocks = {
  prod = "10.0.0.0/16"
  stg  = "10.1.0.0/16"
  dev  = "10.2.0.0/16"
}

subnet_01_cidr_blocks = {
  prod = "10.0.1.0/24"
  stg  = "10.1.1.0/24"
  dev  = "10.2.1.0/24"
}

subnet_02_cidr_blocks = {
  prod = "10.0.2.0/24"
  stg  = "10.1.2.0/24"
  dev  = "10.2.2.0/24"
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
  prod = 8080
  stg  = 8080
  dev  = 8080
}

ecs_host_port = {
  prod = 8080
  stg  = 8080
  dev  = 8080
}

#Applicaiton related variables
application_image_name    = "conversion-app"
application_image_version = "latest"
