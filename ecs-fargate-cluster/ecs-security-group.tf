resource "aws_security_group" "ecs-security-group" {
  name        = "${terraform.workspace}-ecs-security-group"
  description = "Security group for ECS Load Balancer control acess to the ALB"
  vpc_id      = aws_vpc.conversion-app-vpc.id

  ingress {
    from_port   = var.ecs_host_port[terraform.workspace]
    to_port     = var.container_port[terraform.workspace]
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr_block]
  }

  tags = {
    Name = "${terraform.workspace}-ecs-security-group"
  }
}