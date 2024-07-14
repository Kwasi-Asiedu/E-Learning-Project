output "ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_iam_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.ecs_policy_attachment.policy_arn
}

output "iam_policy_document" {
  value = data.aws_iam_policy_document.ecs_policy_document.id
}