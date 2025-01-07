resource "aws_iam_role" "ecs-iam-role" {
  name               = "${terraform.workspace}-ecs-execution-role"
  assume_role_policy = file("${path.module}/ecs-iam-role.json")
}