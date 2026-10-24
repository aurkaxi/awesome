local apps = require 'config.apps'
local awful = require 'awful'
local beautiful = require 'beautiful'

local _M = {}
_M.awesomemenu = {
    { 'hotkeys',     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { 'manual',      apps.manual_cmd },
    { 'edit config', apps.editor_cmd .. ' ' .. awesome.conffile },
    { 'restart',     awesome.restart },
    { 'quit',        function() awesome.quit() end },
}

_M.mainmenu = awful.menu {
    items = {
        { 'awesome',       _M.awesomemenu, beautiful.awesome_icon },
        { 'open terminal', apps.terminal }
    }
}
return _M

