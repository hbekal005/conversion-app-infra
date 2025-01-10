resource "aws_lb_target_group" "ecs-target-group" {
  name        = "${terraform.workspace}-ecs-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "${terraform.workspace}-ecs-target-group"
  }

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "30"
    path                = "/"
    unhealthy_threshold = "2"
  }
}