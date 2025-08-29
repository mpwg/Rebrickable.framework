#!/bin/bash

# CI Validation Script
# Verifies that all GitHub Actions workflows are properly configured

echo "🔍 Validating GitHub Actions workflows..."
echo

# Check if all required workflow files exist
required_workflows=(
    ".github/workflows/ci.yml"
    ".github/workflows/code-quality.yml"
    ".github/workflows/security.yml"
    ".github/workflows/release.yml"
    ".github/workflows/repository-health.yml"
)

all_present=true
for workflow in "${required_workflows[@]}"; do
    if [ -f "$workflow" ]; then
        echo "✅ $workflow"
    else
        echo "❌ $workflow (missing)"
        all_present=false
    fi
done

echo

# Check Package.swift files
if [ -f "Package.swift" ]; then
    echo "✅ Root Package.swift (for CI)"
else
    echo "❌ Root Package.swift (missing)"
    all_present=false
fi

if [ -f "package/Package.swift" ]; then
    echo "✅ package/Package.swift"
else
    echo "❌ package/Package.swift (missing)"
    all_present=false
fi

echo

# Validate Package.swift syntax
echo "🔧 Validating Package.swift syntax..."
if swift package dump-package > /dev/null 2>&1; then
    echo "✅ Package.swift syntax is valid"
else
    echo "❌ Package.swift has syntax errors"
    all_present=false
fi

echo

# Check for platform requirements
if grep -q "macOS(.v14)" Package.swift && grep -q "iOS(.v17)" Package.swift; then
    echo "✅ Realistic platform requirements set"
else
    echo "❌ Platform requirements may be unrealistic"
    all_present=false
fi

echo

# Summary
if [ "$all_present" = true ]; then
    echo "🎉 All workflows validated successfully!"
    echo "✅ CI should run without errors"
    exit 0
else
    echo "❌ Some issues found in workflow configuration"
    exit 1
fi