# conversion-app-infra

## Architecture Description

- **VPC**: A Virtual Private Cloud (VPC) to host all the resources.
- **Subnets**: Two public subnets for deploying ECS tasks.
- **Internet Gateway**: An Internet Gateway to allow internet access to the VPC.
- **Route Table**: A route table associated with the subnets to route traffic through the Internet Gateway.
- **Security Groups**: Security groups to control inbound and outbound traffic for the ECS tasks and load balancer.
- **Load Balancer**: An Application Load Balancer (ALB) to distribute incoming traffic to the ECS tasks.
- **Target Group**: A target group associated with the ALB to route traffic to the ECS tasks.
- **ECS Cluster**: An ECS cluster to manage the ECS tasks.
- **ECS Task Definition**: A task definition specifying the container configuration.
- **ECS Service**: An ECS service to manage the deployment and scaling of the ECS tasks.
- **IAM Roles and Policies**: IAM roles and policies to grant necessary permissions to the ECS tasks.

## Architecture Diagram
