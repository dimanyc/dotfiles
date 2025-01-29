#!/bin/bash

set -e

DOTFILES="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
  echo -e "${GREEN}==>${NC} $1"
}

warn() {
  echo -e "${YELLOW}Warning:${NC} $1"
}

error() {
  echo -e "${RED}Error:${NC} $1"
  exit 1
}

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p &>/dev/null; then
  log "Installing Xcode Command Line Tools..."
  xcode-select --install
  warn "Please wait for Xcode Command Line Tools to install, then press any key to continue..."
  read -n 1
fi

# Install Rosetta 2 for Apple Silicon Macs
if [[ $(uname -m) == 'arm64' ]]; then
  log "Installing Rosetta 2..."
  softwareupdate --install-rosetta --agree-to-license
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Add Homebrew to zprofile for future shell sessions
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zprofile"
  fi
fi

# Create necessary directories
log "Creating necessary directories..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$HOME/.local/share/tmux/plugins"

# Symlink configurations
log "Creating symlinks..."

# Define an array of symlinks to create
declare -A symlinks=(
    ["$HOME/.asdf"]="$DOTFILES/.config/asdf"
    ["$HOME/.config"]="$DOTFILES/.config"
    ["$HOME/.tmux"]="$DOTFILES/.config/tmux"
    ["$HOME/.tmux.conf"]="$DOTFILES/.config/tmux/tmux.conf"
    ["$HOME/.zshrc"]="$DOTFILES/.config/zsh/.zshrc"
)

# Create symlinks
for target in "${!symlinks[@]}"; do
    source="${symlinks[$target]}"
    
    # Remove existing file/directory/symlink if it exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        log "Removing existing $target"
        rm -rf "$target"
    fi
    
    # Create the symlink
    log "Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
done

# Create traditional config directory symlinks
for dir in nvim alacritty cspell tmux; do
    if [ -d "$DOTFILES/.config/$dir" ]; then
        ln -sf "$DOTFILES/.config/$dir" "$CONFIG_DIR/$dir"
        log "Linked $dir configuration"
    fi
done

# Install Tmux Plugin Manager
TPM_PATH="$HOME/.local/share/tmux/plugins/tpm"
if [ ! -d "$TPM_PATH" ]; then
  log "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
fi

# Install Homebrew packages
log "Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

# Set macOS defaults
log "Setting macOS defaults..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Kill affected applications
for app in "Finder" "SystemUIServer"; do
  killall "${app}" &>/dev/null
done

log "Installation complete! 🎉"
log "Remember to:"
echo "1. Start tmux and press prefix + I to install tmux plugins"
echo "2. Open nvim and wait for plugins to install"
echo "3. Restart your computer to ensure all changes take effect"
