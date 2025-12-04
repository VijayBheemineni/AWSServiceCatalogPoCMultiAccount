#!/bin/bash
# Security verification script for public repository
# Checks that no sensitive information is committed

set -e

echo "Verifying repository security..."
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check 1: Verify backend.hcl is gitignored
echo "Check 1: Verify backend.hcl is gitignored"
if git check-ignore terraform/backend.hcl > /dev/null 2>&1; then
    echo -e "${GREEN} backend.hcl is properly gitignored${NC}"
else
    echo -e "${RED} backend.hcl is NOT gitignored!${NC}"
fi
echo ""

# Check 2: Verify backend.hcl is not tracked
echo "Check 2: Verify backend.hcl is not in git"
if git ls-files | grep -q "backend.hcl$"; then
    echo -e "${RED} backend.hcl is tracked in git!${NC}"
    echo "   Run: git rm --cached terraform/backend.hcl"
else
    echo -e "${GREEN} backend.hcl is not tracked${NC}"
fi
echo ""


# Check 3: Verify accounts.yaml is gitignored
echo "Check 3: Verify accounts.yaml is gitignored"
if git check-ignore terraform/products/accounts.yaml > /dev/null 2>&1; then
    echo -e "${GREEN} accounts.yaml is properly gitignored${NC}"
else
    echo -e "${RED} accounts.yaml is NOT gitignored!${NC}"
fi
echo ""

# Check 4: Verify *.tfvars are gitignored
echo "Check 4: Verify *.tfvars are gitignored"
if grep -q '^\*\.tfvars'  .gitignore; then
    echo -e "${GREEN} *.tfvars are gitignored${NC}"
else
    echo -e "${RED} *.tfvars are NOT gitignored!${NC}"
fi
echo ""

# Check 5: Verify terraform.tfvars is not tracked
echo "Check 5: Verify terraform.tfvars is not in git"
if git ls-files | grep -q "terraform.tfvars$"; then
    echo -e "${RED} terraform.tfvars is tracked in git!${NC}"
    echo "   Run: git rm --cached terraform/terraform.tfvars"
else
    echo -e "${GREEN} terraform.tfvars is not tracked${NC}"
fi
echo ""

# Check 6: Search for AWS Access Keys
echo "📋Check 6: Search for AWS Access Keys"
if git ls-files | xargs grep -E "AKIA[0-9A-Z]{16}" 2>/dev/null | grep -v "verify-security.sh" > /dev/null; then
    echo -e "${RED} Found AWS Access Key in committed files!${NC}"
    git ls-files | xargs grep -E "AKIA[0-9A-Z]{16}" 2>/dev/null | grep -v "verify-security.sh"
else
    echo -e "${GREEN} No AWS Access Keys found${NC}"
fi
echo ""

# Check 7: Search for AWS Secret Access Keys
echo " Check 7: Search for AWS Secret Access Keys"
if git ls-files | xargs grep -i "aws_secret_access_key\s*=\s*['\"][^'\"]\+" 2>/dev/null | grep -v "verify-security.sh" > /dev/null; then
    echo -e "${RED} Found AWS Secret Access Key in committed files!${NC}"
    git ls-files | xargs grep -i "aws_secret_access_key\s*=" 2>/dev/null | grep -v "verify-security.sh"
else
    echo -e "${GREEN} No AWS Secret Access Keys found${NC}"
fi
echo ""


# Check 8: Verify example files exist
echo "Check 8: Verify example files exist"
EXAMPLE_FILES=(
    "terraform/backend.hcl.example"
    "terraform/terraform.tfvars.example"
)

for file in "${EXAMPLE_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN} $file exists${NC}"
    else
        echo -e "${YELLOW}  $file is missing${NC}"
    fi
done
echo ""
