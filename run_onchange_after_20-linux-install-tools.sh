#!/usr/bin/env bash
set -euo pipefail

# WSL/Linux baseline. Package names intentionally match Debian/Ubuntu.
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y \
    git \
    zsh \
    neovim \
    ripgrep \
    fd-find \
    fzf \
    jq \
    curl \
    unzip
else
  echo 'apt-get not found; skipping Linux package bootstrap.'
fi
