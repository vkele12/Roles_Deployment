output "debug_info" {
  value = {
    lpa_output_file_role_change = var.lpa_output_file_role_change
    aws_iam_roles              = aws_iam_role.plx-user-management-deployment-roles # Adjust this based on your actual resource structure
  }
}

output "deployed_role_id" {
  value = aws_iam_role[var.lpa_output_file_role_change] ? aws_iam_role[var.lpa_output_file_role_change].id : null
}

output "deployed_role_arn" {
  value = aws_iam_role[var.lpa_output_file_role_change] ? aws_iam_role[var.lpa_output_file_role_change].arn : null
}
