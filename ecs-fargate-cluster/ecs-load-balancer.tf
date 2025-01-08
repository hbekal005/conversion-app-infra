# Create an Application Load Balancer for the ECS Cluster
resource "aws_lb" "ecs-cluster-lb" {
  name               = "${terraform.workspace}-ecs-cluster-lb"
  subnets            = aws_subnet.ecs-public-subnet[*].id
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-security-group-lb.id]

  tags = {
    Application = "${terraform.workspace}-conversion-app"
  }
}

# Create a Listener for the Application Load Balancer
resource "aws_lb_listener" "https-forward" {
  load_balancer_arn = aws_lb.ecs-cluster-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-target-group.arn
  }
}