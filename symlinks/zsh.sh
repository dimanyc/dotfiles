#!/usr/bin/env bash

RC_SOURCE="$HOME/dotfiles/zsh/zshrc"
RC_TARGET="$HOME/.zshrc"

if [ -L "$RC_TARGET" ]; then
  echo "already a symlink. Skipping."
elif [ -d "$RC_TARGET" ]; then
  echo "already exists as a directory. Backing it up..."
  mv "$RC_TARGET" "${RC_TARGET}.backup.$(date +%s)"
  ln -s "$RC_SOURCE" "$RC_TARGET"
  echo "Symlinked $RC_TARGET -> $RC_SOURCE"
else
  ln -s "$RC_SOURCE" "$RC_TARGET"
  echo "Symlinked $RC_TARGET -> $RC_SOURCE"
fi


PLUGINS_SOURCE="$HOME/dotfiles/zsh/zsh_plugins"
PLUGINS_TARGET="$HOME/.zsh_plugins.txt"

if [ -L "$PLUGINS_TARGET" ]; then
  echo "already a symlink. Skipping."
elif [ -d "$PLUGINS_TARGET" ]; then
  echo "already exists as a directory. Backing it up..."
  mv "$PLUGINS_TARGET" "${PLUGINS_TARGET}.backup.$(date +%s)"
  ln -s "$PLUGINS_SOURCE" "$PLUGINS_TARGET"
  echo "Symlinked $PLUGINS_TARGET -> $PLUGINS_SOURCE"
else
  ln -s "$PLUGINS_SOURCE" "$PLUGINS_TARGET"
  echo "Symlinked $PLUGINS_TARGET -> $PLUGINS_SOURCE"
fi


zsh "$HOME/.zshrc"
