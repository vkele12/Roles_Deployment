output "debug_info" {
  value = local.lpa_output_file_role_change
}

output "deployed_role_id" {
  value = aws_iam_role.plx-user-management-deployment-roles.id
}

output "deployed_role_arn" {
  value = aws_iam_role.plx-user-management-deployment-roles.arn
}

