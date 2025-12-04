# AWS Service Catalog Multi-Account Solution

A Terraform-based solution for managing AWS Service Catalog portfolios and
products across multiple AWS accounts using a hub-and-spoke architecture.

Note :- This is just PoC to test ServiceCatalog Deployment using Github Actions
CICD

## Overview

This solution enables centralized management of AWS resources through Service
Catalog, allowing teams to provision standardized resources (like S3 buckets)
across multiple AWS accounts with consistent naming, tagging, and security
configurations.

## Requirements

### Requirement 1

- **Implement Basic Setup of Terraform directories and related files** :- done

### Requirement 2

- **Setup Pre-Commit Configuration** :- done
- **Create Makefile** :- done

```sh
# Pre commit commands
# Note :- Fixed markdownlint issue of line length by adding ".markdownlint.json" and disabling "MD013" check.
# pre-commit run prettier --all-files and then add files to stage and commit.
pre-commit install # done through shell script
pre-commit install --install-hooks # done through shell script
make pre-commit-all # Runs all pre commits
p`re-commit run prettier --all-files # run prettier
```

```sh
# Make commands
make help
make clean
make setup
make pre-commit-all
```

- **Validation** :-

```sh
# Before commiting execute 'make pre-commit-all two times(First time corrects the issues, second time validates the issues.)'
# Add files and then commit.
```

### Requirement 3

- **Terraform state setup** :- done. # Make sure to create your own backend.hcl
  file and update it with your setup values. Check backend.hcl.example file.
- **Terraform basic files setup** :- done # Make sure create your own
  terraform.tfvars file and update it with your setup values. Check
  terraform.tfvars.example file.
- **Validation** -

```sh
# Make sure 'terraform.tfvars' file exists with updated values.
# Make sure 'backend.hcl' fle exists with updated values.

# Log into AWS account through CLI and Execute terraform init
aws sts get-caller-identity
cd terraform
terraform init -backend-config=backend.hcl
terraform plan  # Automatically loads terraform.tfvars!
```


## Code
### Commit Steps
```sh
# Make changes
# Make sure executed from root directory.
make pre-commit-all
git add .
git commit -m "test commit command"
```

### Create Feature Branch for changes
### Create Bug Branch for changes

## Terraform

### Commands
```sh
cd terraform
terraform init -backend-config=backend.hcl
```
