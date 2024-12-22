local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

config.font = wezterm.font 'UDEV Gothic 35NF'
config.font_size = 13.0
config.tab_max_width = 32

config.keys = {
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action { SendString="\x1bb" }
  },
    -- Make Option-Right equivalent to Alt-f; forward-word
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action { SendString="\x1bf" }
  },
}

return config
