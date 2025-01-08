resource "aws_ecs_service" "ecs_service" {
  name                               = "${terraform.workspace}_ecs_service"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = aws_ecs_cluster.conversion-app-ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.ecs-task-definition.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = var.app_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  depends_on                         = [aws_lb_listener.https-forward, aws_iam_role_policy.ecs-iam-policy]


  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-target-group.arn
    container_name   = "${terraform.workspace}-container"
    container_port   = 80
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs-tasks-sg.id]
    subnets          = [aws_subnet.ecs-private-subnet.*.id]
  }
}