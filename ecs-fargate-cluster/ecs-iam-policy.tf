resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs-iam-policy" {
  name   = "${terraform.workspace}-ecs-execution-role-policy"
  role   = aws_iam_role.ecs-iam-role.id
  policy = file("${path.module}/ecs-iam-policy.json")
}