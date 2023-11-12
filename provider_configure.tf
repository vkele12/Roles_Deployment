provider "aws" {
  default_tags {
    tags = var.default_tags
  }
  assume_role {
    role_arn     = "arn:aws:iam::${var.role_deployment_account_id}:role/${var.deploying_role}"
    session_name = "role_deployment"
  }
  alias = "main"
}
