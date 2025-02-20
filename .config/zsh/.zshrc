# ~/.zshrc
 
# Plugin management
source ~/.dotfiles/.config/zsh/plugins/antidote/antidote.zsh
antidote load

# Starship prompt
eval "$(starship init zsh)"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# aliases
source ~/.zsh_aliases

# Brew to PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# bun completions
[ -s "/Users/dimitrynazarov/.bun/_bun" ] && source "/Users/dimitrynazarov/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(mise activate zsh)"
