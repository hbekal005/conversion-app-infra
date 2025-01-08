# Output the ECS DNS Name
output "ecs_dns_name" {
  value = aws_lb.ecs-cluster-lb.dns_name
}