## output will contain id of the deployed role
output "deployed_role_id" {
  value = aws_iam_role.${var.lpa_output_file_role_change}.id
}

output "deployed_role_arn" {
  value = aws_iam_role.${var.lpa_output_file_role_change}.arn
}
