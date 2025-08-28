local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 19
config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "main", "zsh" }
config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.keys = {
	-- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({ key = "f", mods = "ALT" }),
	},
}

return config
