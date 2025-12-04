# Input Variables
# This file defines all input variables used in the Terraform configuration

variable "aws_region" {
  description = "AWS region where Service Catalog resources will be created"
  type        = string
  default     = "us-west-2"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "AWS region must be a valid region format (e.g., us-west-2, eu-west-1)."
  }
}

variable "hub_account_id" {
  description = "AWS account ID of the hub account where Service Catalog portfolio is hosted"
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.hub_account_id))
    error_message = "Hub account ID must be a 12-digit number."
  }
}

# variable "hub_account_role_arn" {
#   description = "IAM role ARN in hub account used by GitHub Actions (OIDC role)"
#   type        = string
#   default     = ""

#   validation {
#     condition     = var.hub_account_role_arn == "" || can(regex("^arn:aws:iam::[0-9]{12}:role/[a-zA-Z0-9+=,.@_-]+$", var.hub_account_role_arn))
#     error_message = "Hub account role ARN must be a valid IAM role ARN format or empty string."
#   }
# }
