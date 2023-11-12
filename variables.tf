variable "deploying_role" {
  description = "Role used to deploy the service deployment role module. "
  type        = string
  default     = "aws-saas-platform-devops-admin"
}
variable "role_deployment_account_id" {
  type        = string
  description = "Account where the service role will be deployed"
 # default     = "003639144106"
}

variable "artifacts_account_id" {
  description = "Artifacts AWS Account. Every service role should trust this account. "
  type        = string
  default     = "459401590044"
}

variable "github_runner_account_id" {
  description = "AWS Account of GitHub Self-Hosted Runners. Every service role should trust this account and its IAM role. SHOULD NOT BE TOUCHED, UNLESS ASKED BY DEVOPS! "
  type        = string
  default     = "823297168014"
}

variable "github_runner_role" {
  description = "GitHub Self-Hosted Runners IAM role. Every service role should trust this account and its IAM role. SHOULD NOT BE TOUCHED, UNLESS ASKED BY DEVOPS! "
  type        = string
  default     = "github-runner-instance-profile"
}

variable "lpa_human_role" {
  description = "Human role that is trusted for assuming the service deployment role. Usually, aws-platformx-lpa-app-admin. If some services require different role, it should be defined in the consume"
  type        = string
  default     = "aws-platformx-lpa-app-admin"
}

variable "default_tags" {
  description = "List of tags - when not empty, will be added to the resources"
  type        = map(string)
  default     = {}
}

variable "lpa_organization_ou" {
  description = "Organization OU id, shall be set for DevOU when role developed in DevOU account; TestOU - when in TestOU account etc."
  type        = string
 # default     = "ou-9d1y-91f03w0t"
}

variable "lpa_output_file_role_change" {
  description = "Output.tf file role name change."
  type        = string
  
}
