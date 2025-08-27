source "$(dirname "$0")/_link_with_backup.sh"

link_with_backup "$HOME/dotfiles/config" "$HOME/.config"
link_with_backup "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
link_with_backup "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"
link_with_backup "$HOME/dotfiles/zsh/zsh_plugins.txt" "$HOME/.zsh_plugins.txt"

zsh "$HOME/.zshrc"
