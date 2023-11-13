output "debug_info" {
  value = {
    lpa_output_file_role_change = local.lpa_output_file_role_change
    all_iam_roles = aws_iam_role
  }
}
output "deployed_role_id" {
  value = aws_iam_role[local.lpa_output_file_role_change].id
}

output "deployed_role_arn" {
  value = aws_iam_role[local.lpa_output_file_role_change].arn
}
