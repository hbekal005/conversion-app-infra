resource "aws_ecs_service" "ecs_service" {
  name                          = "${terraform.workspace}_ecs_service"
  launch_type                   = "FARGATE"
  platform_version              = "LATEST"
  cluster                       = aws_ecs_cluster.conversion-app-ecs-cluster.id
  task_definition               = aws_ecs_task_definition.ecs-task-definition.arn
  scheduling_strategy           = "REPLICA"
  desired_count                 = var.app_count
  availability_zone_rebalancing = "ENABLED"
  depends_on                    = [aws_lb_listener.alb-http-listener, aws_iam_role_policy.ecs-iam-policy]


  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-target-group.arn
    container_name   = "${terraform.workspace}-container"
    container_port   = var.container_port[terraform.workspace]
  }

  network_configuration {
    security_groups = [aws_security_group.ecs-security-group.id]
    subnets         = [aws_subnet.ecs-subnet-01.id, aws_subnet.ecs-subnet-02.id]
  }
}