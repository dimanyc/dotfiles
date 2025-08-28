# Install Homebrew
# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

# Update & upgrade if brew exists
brew update
brew upgrade

# Install packages
apps=(
  alacritty
  antidote
  ca-certificates
  font-hack-nerd-font
  gettext
  gmp
  libevent
  libgit2
  libssh2
  libunistring
  libuv
  libyaml
  llvm
  lpeg
  luajit
  luv
  lz4
  mise
  mpdecimal
  ncurses
  neovim
  openssl@3
  pkgconf
  postgresql@14
  python@3.13
	raycast
  readline
  ripgrep
  rust
	slack
	spotify
  sqlite
  starship
  tmux
  tpm
  tree-sitter
  unibilium
  utf8proc
  wezterm
  xz
  z3
  zstd
)
for app in "${apps[@]}"; do
  if brew list --formula "$app" &>/dev/null || brew list --cask "$app" &>/dev/null; then
    echo "$app already installed, skipping."
  else
    echo "Installing $app..."
    brew install "$app"
  fi
done
