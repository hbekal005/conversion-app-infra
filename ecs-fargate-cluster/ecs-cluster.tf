# Purpose: Create ECS cluster for conversion app
resource "aws_ecs_cluster" "conversion-app-ecs-cluster" {
  name = "${terraform.workspace}-converson-app-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${terraform.workspace}-converson-app-ecs-cluster"
  }
}