-- Standard awesome modulesrary --
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local lain = require("module.lain")

local vars = require 'config.user'
local widgets = require("ui.wibar.module")
local bling = require("module.bling")
local helpers = require "helpers"

local beautiful = require("beautiful")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local dpi = beautiful.xresources.apply_dpi


local clock = widgets.clock         --
local date = widgets.date           --
local cpu = widgets.cpu             --
local battery = widgets.battery     --
local keyboard = widgets.keyboard   --
local mem = widgets.mem             --
local systray = widgets.systray     --
local audio = widgets.audio         --
local seperator = widgets.seperator --
local layoutbox = widgets.layoutbox --
local tomato = widgets.tomato       --
local net = widgets.net             --

local function create_icon(i, c)    --Icon Creation
    local widget = {
        {
            font = "FiraCode Nerd Font 12.5",
            text = ' ' .. i,
            widget = wibox.widget.textbox
        },
        fg = c,
        widget = wibox.container.background
    }
    return widget
end

-- Create Icons with Color --
local calendar_icon = create_icon('󰃭 ', beautiful.xcolor5)
local clock_icon = create_icon('󰥔 ', beautiful.xcolor12)
local keyboard_icon = create_icon('󰌌 ', beautiful.xcolor4)

-- local function shuffle(array)
--     for i = #array, 2, -1 do
--         local j = math.random(i)
--         array[i], array[j] = array[j], array[i]
--     end
-- end

-- -- Define layouts
-- local specifiedLayouts = {
--     awful.layout.layouts[1],  -- First layout for the first tag
--     awful.layout.layouts[2],  -- Second layout for the second tag
--     awful.layout.layouts[1],  -- First layout for the third tag
--     awful.layout.layouts[3],  -- Third layout for the fourth tag
--     -- Add more layouts as needed
-- }

-- -- Shuffle the remaining layouts
-- local shuffledLayouts = {table.unpack(awful.layout.layouts)}
-- table.remove(shuffledLayouts, 1)  -- Remove the layouts already specified
-- shuffle(shuffledLayouts)  -- Shuffle the remaining layouts

-- -- Combine specified and shuffled layouts
-- local allLayouts = {
--     specifiedLayouts[1], specifiedLayouts[2], shuffledLayouts[1], specifiedLayouts[3], shuffledLayouts[2], specifiedLayouts[4]
--     -- Continue combining layouts for each tag
-- }

-- Assign layouts to tags
-- awful.tag({ "", "", "", "", "", "" }, s, allLayouts)
-- awful.tag(vars.tags, s, awful.layout.layouts)
-- for s in screen do
--     s.tag = awful.tag(vars.tags, s, vars.layouts)
-- end
-- LAIN TESTS


screen.connect_signal("request::desktop_decoration", function(s)
    -- Crate tags
    --   awful.tag(vars.tags, s, awful.layout.layouts)

    -- Create Clock with Colerfull Widget --
    local clockdate = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        calendar_icon,
        date,
        clock_icon,
        clock, -- Middle widget


    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        bg       = beautiful.transparent,
        margins  = {
            top = 5,
            left = 5,
            right = 5,
            bottom = 0
        },
        widget   = {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    s.taglist,
                    seperator,
                    tomato,
                },
                left = 5, --Padding
                right = 0,
                top = 2,
                bottom = 2,
                layout = wibox.container.margin,

            },
            {
                { -- middle widget
                    layout = wibox.layout.align.horizontal,
                    clockdate,
                },
                left = 0,
                right = 0,
                top = 1,
                bottom = 1,
                layout = wibox.container.margin,
            },
            { -- Right widgets
                {
                    --temp.text,
                    systray,
                    seperator,
                    audio,
                    mem,
                    cpu,
                    battery,
                    net,
                    keyboard_icon,
                    keyboard,
                    -- lains
                    -- lalsa.widget,
                    --awful.widget.systray(),
                    -- power,
                    s.layoutbox,
                    --pacing = 2,
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 0,
                right = 2,
                top = 1,
                bottom = 1,
                layout = wibox.container.margin
            },

        }
    }
    s.btmbar = awful.wibar {
        position = "bottom",
        screen = s,
        bg = beautiful.transparent,
        margins = {
            top = 0,
            left = 5,
            right = 5,
            bottom = 5
        },
        widget = {
            layout = wibox.layout.align.horizontal,
            {
                space,
                layout = wibox.layout.fixed.horizontal
            },
            {
                s.tasklist,
                left = 20,
                top = 2,
                bottom = 2,
                right = 20,
                layout = wibox.container.margin
            },
            {
                space,
                layout = wibox.layout.fixed.horizontal
            }
        }
    }
end)
