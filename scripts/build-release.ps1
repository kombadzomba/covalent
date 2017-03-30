#!/bin/bash

# set -o errexit

# # Clear deploy/ so that we guarantee there are no stale artifacts.
# echo "Cleaning deploy/"
rm -r ./deploy

# Perform a build.
gulp build
echo "SASS compiled..."

# Prepare for aot
gulp prepare-aot
echo "Preparing files for AoT build"

# AoT compilation
npm run aot
echo "Compiled TS and generated *.metadata.json files..."

# Clean source .ts files
cd deploy/
get-childitem -include *.ts -recurse | foreach ($_) {remove-item $_.fullname}
get-childitem -include *.d.ts -recurse | foreach ($_) {remove-item $_.fullname}
cd ..
echo "Remove source .ts files so they arent published"

# Inline the css and html into the component files.
gulp inline-resource-files
echo "Resources inlined..."

# Bundle
gulp rollup-code
echo "Bundled..."
