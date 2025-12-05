# AWS OIDC Authentication Action

A reusable composite action for authenticating to AWS using OIDC (OpenID Connect).

## Description

This action configures AWS credentials using OIDC and verifies the authentication by calling `aws sts get-caller-identity`.

## Inputs

| Input | Description | Required |
|-------|-------------|----------|
| `role-arn` | AWS IAM Role ARN to assume | Yes |
| `aws-region` | AWS Region | Yes |
| `session-name` | Role session name for identification | Yes |

## Usage

### In Your Workflow

```yaml
jobs:
  my-job:
    runs-on: ubuntu-latest
    permissions:
      id-token: write  # Required for OIDC
      contents: read

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Authenticate to AWS
        uses: ./.github/actions/aws-auth
        with:
          role-arn: ${{ secrets.OIDC_ROLE_ARN }}
          aws-region: ${{ secrets.AWS_REGION }}
          session-name: GitHubActions-MyJob

      - name: Use AWS CLI
        run: |
          aws s3 ls
          aws sts get-caller-identity
```
