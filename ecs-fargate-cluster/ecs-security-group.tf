resource "aws_security_group" "ecs-security-group-lb" {
  name        = "${terraform.workspace}_ecs_security_group_lb"
  description = "Security group for ECS Load Balancer control acess to the ALB"
  vpc_id      = aws_vpc.conversion-app-vpc.id

  ingress {
    from_port   = lookup(var, "${terraform.workspace}_ecs_host_port")
    to_port     = lookup(var, "${terraform.workspace}_container_port")
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
    Name = "${terraform.workspace}-ecs-security-group-lb"
  }
}

resource "aws_security_group" "ecs-tasks-sg" {
  name        = "${terraform.workspace}-ecs-tasks-sg"
  description = "Inbound access from the ALB only"
  vpc_id      = aws_vpc.conversion-app-vpc.id
  ingress {
    protocol        = "tcp"
    from_port       = lookup(var, "${terraform.workspace}_ecs_host_port")
    to_port         = lookup(var, "${terraform.workspace}_container_port")
    cidr_blocks     = [var.all_cidr_block]
    security_groups = [aws_security_group.ecs-security-group-lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.all_cidr_block]
  }
}