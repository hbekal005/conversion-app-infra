resource "aws_iam_role_policy" "ecs-iam-policy" {
  name   = "${terraform.workspace}-ecs-execution-role-policy"
  role   = aws_iam_role.ecs-iam-role.id
  policy = file("${path.module}/ecs-iam-policy.json")
}