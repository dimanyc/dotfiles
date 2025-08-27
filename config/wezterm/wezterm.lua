local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 19
config.default_prog = { "/opt/homebrew/opt/tmux", "new-session", "-A", "-s", "main", "zsh" }
config.automatically_reload_config = true

return config
