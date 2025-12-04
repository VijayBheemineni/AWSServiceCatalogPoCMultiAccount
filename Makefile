.PHONY: help setup pre-commit pre-commit-all fmt validate lint security yaml-lint md-lint check-all clean

# Default target
help:
	@echo "Available targets:"
	@echo "  setup            - Setup pre-commit hooks and dependencies"
	@echo "  pre-commit       - Run pre-commit on staged files"
	@echo "  pre-commit-all   - Run pre-commit on all files"
	@echo "  fmt              - Format Terraform files"
	@echo "  validate         - Validate Terraform configuration"
	@echo "  lint             - Run TFLint on Terraform files"
	@echo "  security         - Run Checkov security scan on Terraform files"
	@echo "  yaml-lint        - Lint YAML files"
	@echo "  md-lint          - Lint Markdown files"
	@echo "  check-all        - Run all checks (fmt, validate, lint, security)"
	@echo "  clean            - Clean Terraform artifacts"

# Setup pre-commit hooks
setup:
	@echo "Setting up pre-commit hooks..."
	@./scripts/setup-pre-commit.sh

# Run pre-commit on staged files
pre-commit:
	@echo "Running pre-commit on staged files..."
	@pre-commit run

# Run pre-commit on all files
pre-commit-all:
	@echo "Running pre-commit on all files..."
	@pre-commit run --all-files

# Format Terraform files
fmt:
	@echo "Formatting Terraform files..."
	@cd terraform && terraform fmt -recursive

# Validate Terraform configuration
validate:
	@echo "Validating Terraform configuration..."
	@cd terraform && terraform init -backend=false && terraform validate

# Run TFLint
lint:
	@echo "Running TFLint..."
	@cd terraform && tflint --init && tflint

# Run Checkov security scan
security:
	@echo "Running Checkov security scan..."
	@cd terraform && checkov --directory . --quiet

# Run security verification (check for secrets)
security-check:
	@echo "Running security verification..."
	@./scripts/verify-security.sh

# Lint YAML files
yaml-lint:
	@echo "Linting YAML files..."
	@yamllint .

# Lint Markdown files
md-lint:
	@echo "Linting Markdown files..."
	@markdownlint '**/*.md' --ignore node_modules

# Run all checks
check-all: fmt validate lint security yaml-lint md-lint
	@echo ""
	@echo "✅ All checks completed!"

# Clean Terraform artifacts
clean:
	@echo "Cleaning Terraform artifacts..."
	@find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.tfstate*" -delete 2>/dev/null || true
	@find . -type f -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@echo "Clean complete!"
