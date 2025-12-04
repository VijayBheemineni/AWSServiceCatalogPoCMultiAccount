# Output Values
# This file defines outputs that will be displayed after Terraform apply

output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

output "hub_account_id" {
  description = "Hub account ID"
  value       = var.hub_account_id
}
