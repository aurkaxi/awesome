local gears      = require 'gears'
local config_dir = gears.filesystem.get_configuration_dir()

package.path     = package.path
    .. ";"
    .. config_dir .. "module/?.lua"
    .. ";"
    .. config_dir .. "module/?/init.lua"

pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require 'beautiful'
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default")
beautiful.init(theme_path)
-- beautiful.useless_gap = 5

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'config.rules'
-- load signals
require 'signals'

require('config.tyrannical')
-- ui
require 'module'
require 'ui.wibar'
local awful = require 'awful'
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
