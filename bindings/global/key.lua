local awful = require 'awful'
local naughty = require 'naughty'
local hotkeys_popup = require 'awful.hotkeys_popup'
local menubar = require 'menubar'

local apps = require 'config.apps'
local mod = require 'bindings.mod'

local machi = require 'module.layout-machi'
local xrandr = require("module.xrandr")
require('module.exit-screen')
menubar.utils.terminal = apps.terminal

-- general awesome keys
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { mod.super },
        key         = 'F1',
        description = 'show help',
        group       = 'awesome',
        on_press    = hotkeys_popup.show_help,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = 'r',
        description = 'reload awesome',
        group       = 'awesome',
        on_press    = awesome.restart,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'x',
        description = 'powermenu',
        group       = 'awesome',
        on_press    = function()
            awesome.emit_signal("module::exit_screen:show")
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'Return',
        description = 'Open ScratchPad',
        group       = 'launcher',
        on_press    = function() awesome.emit_signal("scratchpad::toggle") end,
    },
    -- awful.key{
    --     modifiers   = { },
    --     key         = 'XF86Launch1',
    --     description = 'Open ScratchPad',
    --     group       = 'launcher',
    --     on_press    = function() awesome.emit_signal("scratchpad::toggle") end,
    -- },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = 'Return',
        description = 'open a terminal',
        group       = 'launcher',
        on_press    = function() awful.spawn(apps.terminal) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'r',
        description = 'drun',
        group       = 'launcher',
        on_press    = function()
            awful.spawn("/home/aurka/.config/rofi/launchers/launcher.sh")
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = '.',
        description = 'emoji menu',
        group       = 'launcher',
        on_press    = function() awful.spawn("rofimoji") end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'v',
        description = 'clipboard',
        group       = 'launcher',
        on_press    = function()
            awful.spawn("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'a',
        description = 'show notification',
        group       = 'launcher',
        on_press    = function() awesome.emit_signal("action::toggle") end,
    },
}

-- tags related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { mod.super },
        key         = 'Left',
        description = 'view previous',
        group       = 'tag',
        on_press    = awful.tag.viewprev,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'Right',
        description = 'view next',
        group       = 'tag',
        on_press    = awful.tag.viewnext,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'Escape',
        description = 'go back',
        group       = 'tag',
        on_press    = awful.tag.history.restore,
    },
    awful.key {
        modifiers   = { mod.super },
        keygroup    = 'numrow',
        description = 'only view tag',
        group       = 'tag',
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        keygroup    = 'numrow',
        description = 'toggle tag',
        group       = 'tag',
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        keygroup    = 'numrow',
        description = 'move focused client to tag',
        group       = 'tag',
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl, mod.shift },
        keygroup    = 'numrow',
        description = 'toggle focused client on tag',
        group       = 'tag',
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
}

-- focus related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { mod.super },
        key         = 'j',
        description = 'focus next by index',
        group       = 'client',
        on_press    = function() awful.client.focus.byidx(1) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'k',
        description = 'focus previous by index',
        group       = 'client',
        on_press    = function() awful.client.focus.byidx(-1) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'Tab',
        description = 'go back',
        group       = 'client',
        on_press    = function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = 'n',
        description = 'restore minimized',
        group       = 'client',
        on_press    = function()
            local c = awful.client.restore()
            if c then
                c:activate { raise = true, context = 'key.unminimize' }
            end
        end,
    },
}

-- layout related keybindings
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = 'j',
        description = 'swap with next client by index',
        group       = 'client',
        on_press    = function() awful.client.swap.byidx(1) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = 'k',
        description = 'swap with previous client by index',
        group       = 'client',
        on_press    = function() awful.client.swap.byidx(-1) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'u',
        description = 'jump to urgent client',
        group       = 'client',
        on_press    = awful.client.urgent.jumpto,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'l',
        description = 'increase master width factor',
        group       = 'layout',
        on_press    = function() awful.tag.incmwfact(0.05) end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = 'h',
        description = 'decrease master width factor',
        group       = 'layout',
        on_press    = function() awful.tag.incmwfact(-0.05) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = 'h',
        description = 'increase the number of master clients',
        group       = 'layout',
        on_press    = function() awful.tag.incnmaster(1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = 'l',
        description = 'decrease the number of master clients',
        group       = 'layout',
        on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = 'h',
        description = 'increase the number of columns',
        group       = 'layout',
        on_press    = function() awful.tag.incncol(1, nil, true) end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = 'l',
        description = 'decrease the number of columns',
        group       = 'layout',
        on_press    = function() awful.tag.incncol(-1, nil, true) end,
    },
    -- awful.key{
    --     modifiers   = {mod.super},
    --     key         = 'space',
    --     description = 'select next',
    --     group       = 'layout',
    --     on_press    = function() awful.layout.inc(1) end,
    -- },
    -- awful.key{
    --     modifiers   = {mod.super, mod.shift},
    --     key         = 'space',
    --     description = 'select previous',
    --     group       = 'layout',
    --     on_press    = function() awful.layout.inc(-1) end,
    -- },
    awful.key {
        modifiers   = { mod.super },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = '-',
        description = 'edit the current layout if it is a machi layout',
        group       = 'layout',
        on_press    = function() machi.default_editor.start_interactive() end,
    },
    awful.key {
        modifiers   = { mod.super },
        key         = ',',
        description = 'switcch between windows for a machi layout',
        group       = 'layout',
        on_press    = function() machi.switcher.start(client.focus) end,
    },
}

-- Multimedia related keybinds
-- Function to get the current volume percentage
local function getCurrentVolume()
    local volume_info = io.popen("pactl get-sink-volume @DEFAULT_SINK@"):read("*all")
    local current_volume = volume_info:match("Volume: .- ([%d]+)%%")
    return current_volume
end

-- Function to get the current brightness percentage
local function getCurrentBrightness()
    local brightness_info = io.popen("brightnessctl get"):read("*all")
    local current_brightness = tonumber(brightness_info) * 100 / 255
    return current_brightness
end

awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = {},
        key         = 'XF86AudioMute',
        description = 'Toggle Audio',
        group       = 'multimedia',
        on_press    = function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
            local mute_info = io.popen("pactl get-sink-mute @DEFAULT_SINK@"):read("*all")
            local is_muted = mute_info:match("Mute: (%a+)")
            local mute_text = is_muted == "yes" and "Muted" or "Unmuted"
            awesome.emit_signal("widget::update_vol")
            naughty.notify({
                title = 'Audio Toggled',
                text = 'Audio ' .. mute_text,
                timeout = 1
            })
        end,
    },
    awful.key {
        modifiers   = {},
        key         = 'XF86AudioLowerVolume',
        description = 'lower volume',
        group       = 'multimedia',
        on_press    = function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
            local current_volume = getCurrentVolume()
            awesome.emit_signal("widget::update_vol")
            naughty.notify({
                title = 'Volume Decreased',
                text = 'Current Volume: ' .. current_volume .. '%',
                timeout = 1
            })
        end,
    },
    awful.key {
        modifiers   = {},
        key         = 'XF86AudioRaiseVolume',
        description = 'raise volume',
        group       = 'multimedia',
        on_press    = function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
            local current_volume = getCurrentVolume()
            awesome.emit_signal("widget::update_vol")
            naughty.notify({
                title = 'Volume Increased',
                text = 'Current Volume: ' .. current_volume .. '%',
                timeout = 1
            })
        end,
    },
    awful.key {
        modifiers   = {},
        key         = 'XF86MonBrightnessDown',
        description = 'brightness down',
        group       = 'multimedia',
        on_press    = function()
            awful.spawn("brightnessctl set 20%-")
            local current_brightness = getCurrentBrightness()
            naughty.notify({
                title = 'Brightnesss',
                text = string.format('Brightness decreased to %.0f%%', current_brightness),
                timeout = 1
            })
        end,
    },
    awful.key {
        modifiers   = {},
        key         = 'XF86MonBrightnessUp',
        description = 'brightness up',
        group       = 'multimedia',
        on_press    = function()
            awful.spawn("brightnessctl set +20%")
            local current_brightness = getCurrentBrightness()
            naughty.notify({
                title = 'Brightness',
                text = string.format('Brightness increased to %.0f%%', current_brightness),
                timeout = 1
            })
        end,
    },
    awful.key {
        modifiers   = {},
        key         = 'XF86AudioMicMute',
        description = 'toggle mic',
        group       = 'multimedia',
        on_press    = function()
            awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
            local mute_info = io.popen("pactl get-source-mute @DEFAULT_SOURCE@"):read("*all")
            local is_muted = mute_info:match("Mute: (%a+)")
            local mute_text = is_muted == "yes" and "Muted" or "Unmuted"
            naughty.notify({
                title = 'Microphone',
                text = 'Microphone ' .. mute_text,
                timeout = 1
            })
        end,
    },
    awful.key {
        modifiers   = {},
        key         = "XF86TouchpadToggle",
        description = "Toggle Touchpad",
        group       = 'multimedia',
        on_press    = function()
            local id = "9"
            local handle = io.popen("xinput list-props " .. id .. " | grep 'Device Enabled'")
            local result = handle:read("*a")
            handle:close()
            local value = result:match("(%d)%s*$")

            if value == "0" then
                awful.spawn('xinput enable ' .. id)
                notification_text = "Touchpad enabled"
            elseif value == "1" then
                awful.spawn('xinput disable ' .. id)
                notification_text = "Touchpad disabled"
            else
                print("Unknown value: " .. value)
            end

            naughty.notify({
                title = "Touchpad",
                text = notification_text,
                timeout = 1
            })
        end,
    },
}

-- Screenshot
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = {},
        key         = 'Print',
        description = 'Screenshot Area',
        group       = 'Screenshot',
        on_press    = function() awful.spawn('flameshot gui') end,
    },
    awful.key {
        modifiers   = { mod.super, mod.shift },
        key         = 'Print',
        description = 'Screenshot full',
        group       = 'Screenshot',
        on_press    = function() awful.spawn('flameshot full') end,
    },
    awful.key {
        modifiers   = { mod.super, mod.ctrl },
        key         = 'Print',
        description = 'Screenshot Launcher',
        group       = 'Screenshot',
        on_press    = function() awful.spawn('flameshot launcher') end,
    },
}

-- test
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { mod.super },
        key         = '`',
        description = 'test',
        group       = 'test',
        on_press    = function() awful.titlebar.toggle(client.focus) end,
        -- on_press    = function()  xrandr.xrandr() end,
    },
}
