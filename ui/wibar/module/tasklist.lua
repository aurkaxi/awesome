local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require'wibox'
local dpi = beautiful.xresources.apply_dpi

awful.screen.connect_for_each_screen(function(s)
    
    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button{
                modifiers = {},
                button    = 1,
                on_press  = function(c)
                c:activate{context = 'tasklist', action = 'toggle_minimization'}
                end,
            },
            awful.button{
                modifiers = {},
                button    = 3,
                on_press  = function() awful.menu.client_list{theme = {width = 250}} end
            },
            awful.button{
                modifiers = {},
                button    = 4,
                on_press  = function() awful.client.focus.byidx(-1) end
            },
            awful.button{
                modifiers = {},
                button    = 5,
                on_press  = function() awful.client.focus.byidx(1) end
            },
        },
        style    = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape  = gears.shape.rounded_bar,
        },
        layout   = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape        = gears.shape.circle,
                    widget       = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout  = wibox.layout.flex.horizontal
        },

        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = awful.widget.clienticon,  -- Use client icon here
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        }
    }
    
end)