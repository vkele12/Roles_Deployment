output "deployed_role_id" {
  value = aws_iam_role[TF_VAR_2].id
}

output "deployed_role_arn" {
  value = aws_iam_role[TF_VAR_2].arn
}
