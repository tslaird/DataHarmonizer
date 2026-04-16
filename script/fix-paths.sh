#!/usr/bin/env bash
set -e
# Ensure a target directory argument is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <target-dir>"
  exit 1
fi
TARGET_DIR="$1"
# Script to fix path references after populating the docs folder.
# Run this script from the repository root, optionally passing a target directory.
# Usage: ./fix-paths.sh <target-dir>

# Update template paths in any main.js files under docs
find "$TARGET_DIR" -type f -name "main.js" -exec sed -i 's#templates/#/DataHarmonizer/templates/#g' {} +

# Fix escaped regex pattern in any files (adjust if needed)
find "$TARGET_DIR" -type f -exec sed -i 's#/DataHarmonizer\\/templates/#/DataHarmonizer/templates/#g' {} +

# Update HTML file references for schema and script paths
find "$TARGET_DIR" -type f -name "*.html" -exec sed -i \
  -e 's#dist-schemas/schemas.js#./dist-schemas/schemas.js#g' \
  -e 's#scripts/main.js#./scripts/main.js#g' {} +

echo "Path fixes applied."
