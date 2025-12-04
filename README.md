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
pre-commit run prettier --all-files # run prettier
```

```sh
# Make commands
make help
make clean
make setup
make pre-commit-all
```
