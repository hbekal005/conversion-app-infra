resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = "${terraform.workspace}-conversion_app"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs-iam-role.arn
  network_mode             = "awsvpc"
  cpu                      = lookup(var, "${terraform.workspace}_ecs_task_cpu")
  memory                   = lookup(var, "${terraform.workspace}_ecs_task_memory")
  container_definitions = jsonencode([
    {
      name      = "${terraform.workspace}-container"
      image     = "${var.application_image_name}:${var.application_image_version}"
      cpu       = lookup(var, "${terraform.workspace}_ecs_task_cpu")
      memory    = lookup(var, "${terraform.workspace}_ecs_task_memory")
      essential = true
      portMappings = [
        {
          containerPort = lookup(var, "${terraform.workspace}_container_port")
          hostPort      = lookup(var, "${terraform.workspace}_ecs_host_port")
        }
      ]
    }
  ])
}

data "aws_ecs_task_definition" "ecs-task-definition" {
  task_definition = aws_ecs_task_definition.ecs-task-definition.family
}