#!/usr/bin/env bash
set -euo pipefail

echo "Uninstalling all Homebrew packages and casks..."

if command -v brew &>/dev/null; then
  # Uninstall all formulae
  formulae=$(brew list --formula)
  if [ -n "$formulae" ]; then
    echo "Uninstalling formulae..."
    brew uninstall --force --ignore-dependencies $formulae
  fi

  # Uninstall all casks
  casks=$(brew list --cask)
  if [ -n "$casks" ]; then
    echo "Uninstalling casks..."
    brew uninstall --cask --force $casks
  fi

  echo "Running cleanup..."
  brew cleanup --prune=all -s

  echo "Uninstalling Homebrew itself..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

  echo "Removing leftover Homebrew directories..."
  sudo rm -rf /usr/local/Homebrew /usr/local/Caskroom /usr/local/bin/brew
  sudo rm -rf /opt/homebrew /opt/homebrew-cask /opt/homebrew-caskroom

  echo "Done! Homebrew and all packages removed."
else
  echo "Homebrew not installed."
fi
