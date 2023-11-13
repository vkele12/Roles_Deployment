terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-444445230229"
   # key     = "deployment_roles/${var.role_deployment_account_id}/user-management-deployment-role/terraform.tfstate"
   #  key     = var.backend_key
    encrypt = true
    region  = "ap-south-1"
  }
}
