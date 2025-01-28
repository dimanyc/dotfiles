# ~/.zshrc

# Starship prompt
eval "$(starship init zsh)"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# asdf configuration
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# aliases
source ~/.zsh_aliases
