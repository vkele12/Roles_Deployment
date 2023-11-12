terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-444445230229"
    key     = "deployment_roles/003639144106/user-management-deployment-role/terraform.tfstate"
    encrypt = true
    region  = "eu-west-1"
  }
}