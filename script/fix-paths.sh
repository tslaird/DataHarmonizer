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
# Update template paths in docs/scripts/main.js
sed -i 's#templates/#DataHarmonizer/templates/#g' "$TARGET_DIR/scripts/main.js"

# Fix escaped regex pattern 
sed -i 's#\\/templates\\/#\\/DataHarmonizer\\/templates\\/#g' "$TARGET_DIR/scripts/main.js"

# Update HTML file references for schema and script paths
find "$TARGET_DIR" -type f -name "*.html" -exec sed -i -e 's#href="index.html"#href="./DataHarmonizer/index.html"#g' -e 's#dist-schemas/schemas.js#./dist-schemas/schemas.js#g' -e 's#scripts/main.js#./scripts/main.js#g' {} \;

echo "Path fixes applied."
