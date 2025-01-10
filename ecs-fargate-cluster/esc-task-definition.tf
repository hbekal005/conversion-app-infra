resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = "${terraform.workspace}-conversion_app"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs-iam-role.arn
  network_mode             = "awsvpc"
  cpu                      = var.ecs_task_cpu[terraform.workspace]
  memory                   = var.ecs_task_memory[terraform.workspace]

  container_definitions = jsonencode([
    {
      name      = "${terraform.workspace}-container"
      image     = "hbekal005/${var.application_image_name}:${var.application_image_version}"
      cpu       = var.ecs_task_cpu[terraform.workspace]
      memory    = var.ecs_task_memory[terraform.workspace]
      essential = true
      portMappings = [
        {
          containerPort = var.container_port[terraform.workspace]
          hostPort      = var.ecs_host_port[terraform.workspace]
        }
      ]
    }
  ])
}

data "aws_ecs_task_definition" "ecs-task-definition" {
  task_definition = aws_ecs_task_definition.ecs-task-definition.family
}