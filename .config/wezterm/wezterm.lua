local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Material (Gogh)"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true

return config
