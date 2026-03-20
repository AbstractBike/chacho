#!/usr/bin/env bash
# Deploy chacho static site to home-nixos-1
set -euo pipefail

TARGET_HOST="${1:-hn1}"
TARGET_DIR="/var/www/chacho"

echo "→ Deploying to ${TARGET_HOST}:${TARGET_DIR}"

# Create directory with correct permissions for nginx
ssh "$TARGET_HOST" "sudo mkdir -p ${TARGET_DIR} && sudo chown -R nginx:nginx ${TARGET_DIR} && sudo chmod 755 ${TARGET_DIR}"

# Sync files
rsync -av --delete --rsync-path="sudo rsync" \
  public/ \
  "${TARGET_HOST}:${TARGET_DIR}/"

echo "✓ Deployed. Site live at https://chacho.abstract.bike"
