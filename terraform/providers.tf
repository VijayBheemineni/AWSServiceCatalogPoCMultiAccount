# AWS Provider Configuration
# This provider is used to manage AWS Service Catalog resources in the hub account
provider "aws" {
  region = var.aws_region

  # Default tags applied to all resources created by this provider
  default_tags {
    tags = {
      Owner       = "CloudTeam"
      ManagedBy   = "Terraform"
      Project     = "ServiceCatalog"
      Environment = "Infra"
    }
  }
}
