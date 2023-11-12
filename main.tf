module "products-management-deployment-role-consume" {
  source                     = "../../"
  deploying_role             = local.deploying_role
  role_deployment_account_id = local.role_deployment_account_id
  lpa_organization_ou        = local.lpa_organization_ou
  providers = {
    aws.main = aws.main
  }
}
