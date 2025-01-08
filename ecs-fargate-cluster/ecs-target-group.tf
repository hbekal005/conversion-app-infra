resource "aws_lb_target_group" "ecs-target-group" {
  name        = "${terraform.workspace}-ecs-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = ""

  tags = {
    Name = "${terraform.workspace}-ecs-target-group"
  }

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             =  "200-299"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 20
    interval            = 90
  }
}