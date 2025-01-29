# ~/.zshrc


# Starship prompt
eval "$(starship init zsh)"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

. $HOME/.dotfiles/.config/asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

. $ASDF_DIR/plugins/golang/set-env.zsh

# aliases
source ~/.zsh_aliases
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# Brew to PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
