#!/bin/bash
# Setup script for pre-commit hooks (macOS with Homebrew)
# This script installs pre-commit and all required dependencies using Homebrew

set -e

echo " Setting up pre-commit hooks for macOS..."

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo " This script is designed for macOS only."
    echo "   For other operating systems, please install tools manually."
    echo "   See docs/INSTALLATION_METHODS.md for instructions."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo " Homebrew is required but not installed."
    echo "   Install Homebrew from: https://brew.sh"
    echo "   Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo " Homebrew is installed: $(brew --version | head -n1)"
echo ""

# Update Homebrew
echo " Updating Homebrew..."
brew update

# Install pre-commit
if ! command -v pre-commit &> /dev/null; then
    echo " Installing pre-commit..."
    brew install pre-commit
else
    echo " pre-commit is already installed: $(pre-commit --version)"
fi

# Install Terraform
if ! command -v terraform &> /dev/null; then
    echo " Installing Terraform..."
    brew install terraform
else
    echo " Terraform is already installed: $(terraform version | head -n1)"
fi

# Install TFLint
if ! command -v tflint &> /dev/null; then
    echo " Installing TFLint..."
    brew install tflint
else
    echo " TFLint is already installed: $(tflint --version)"
fi

# Install terraform-docs
if ! command -v terraform-docs &> /dev/null; then
    echo " Installing terraform-docs..."
    brew install terraform-docs
else
    echo " terraform-docs is already installed: $(terraform-docs --version)"
fi

# Install Checkov
if ! command -v checkov &> /dev/null; then
    echo " Installing Checkov..."
    brew install checkov
else
    echo " Checkov is already installed: $(checkov --version)"
fi

# Install yamllint
if ! command -v yamllint &> /dev/null; then
    echo " Installing yamllint..."
    brew install yamllint
else
    echo " yamllint is already installed: $(yamllint --version)"
fi

# Install shellcheck
if ! command -v shellcheck &> /dev/null; then
    echo " Installing shellcheck..."
    brew install shellcheck
else
    echo " shellcheck is already installed: $(shellcheck --version | head -n2 | tail -n1)"
fi

# Install Node.js (for markdownlint-cli)
if ! command -v node &> /dev/null; then
    echo " Installing Node.js..."
    brew install node
else
    echo " Node.js is already installed: $(node --version)"
fi

# Install markdownlint-cli
if ! command -v markdownlint &> /dev/null; then
    echo " Installing markdownlint-cli..."
    npm install -g markdownlint-cli
else
    echo " markdownlint is already installed: $(markdownlint --version)"
fi

echo ""
echo " Initializing TFLint plugins..."
cd terraform 2>/dev/null && tflint --init && cd .. || echo " Run 'tflint --init' manually in the terraform directory."
# -----------------------------
# Create minimal .tflint.hcl if missing
# -----------------------------
TFLINT_CONFIG="terraform/.tflint.hcl"

if [ ! -f "$TFLINT_CONFIG" ]; then
    echo ""
    echo "Creating minimal terraform/.tflint.hcl file..."
    cat > "$TFLINT_CONFIG" <<EOF
# Minimal TFLint configuration

plugin "aws" {
  enabled = true
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.34.0"
}

# Example rule
rule "aws_instance_invalid_type" {
  enabled = true
}
EOF
    echo "${TFLINT_CONFIG} created successfully."
else
    echo "${TFLINT_CONFIG} already exists, skipping creation."
fi


echo ""
echo " Installing pre-commit hooks..."
echo "   This will download and setup all hook environments (may take a few minutes)..."
pre-commit install --install-hooks
pre-commit install --hook-type commit-msg

echo ""
echo " Pre-commit setup complete!"
echo ""
echo " Installed tools:"
echo "   • pre-commit: $(pre-commit --version)"
echo "   • terraform: $(terraform version -json | grep -o '"terraform_version":"[^"]*"' | cut -d'"' -f4)"
echo "   • tflint: $(tflint --version | head -n1)"
echo "   • terraform-docs: $(terraform-docs --version | head -n1)"
echo "   • checkov: $(checkov --version)"
echo "   • yamllint: $(yamllint --version)"
echo "   • shellcheck: $(shellcheck --version | grep version: | awk '{print $2}')"
echo "   • markdownlint: $(markdownlint --version)"
echo ""
echo " Next steps:"
echo "   1. Run 'make pre-commit-all' to test all hooks"
echo "   2. Hooks will now run automatically on git commit"
echo "   3. To skip hooks temporarily: git commit --no-verify"
echo "   4. Update tools: brew upgrade"
echo ""
