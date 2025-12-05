# Output Values

output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

output "hub_account_id" {
  description = "Hub account ID"
  value       = var.hub_account_id
}
