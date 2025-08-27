source "$(dirname "$0")/_unlink_symlink.sh"

unlink_symlink "$HOME/.config"
unlink_symlink "$HOME/.tmux.conf"
unlink_symlink "$HOME/.zshrc"
unlink_symlink "$HOME/.zsh_plugins.txt"
