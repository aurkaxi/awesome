local awful = require "awful"
local naughty = require "naughty"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local helpers = require "helpers"

-- Icon
local icon = wibox.widget.textbox()
icon.font = beautiful.font.."12.5"
icon.align = 'center'
-- icon.markup = "<span foreground='"..beautiful.xcolor2.."'>󰂀 </span>"

-- Uptime
local battery = wibox.widget.textbox()
battery.font = beautiful.font.."10"
battery.align = 'center'


local full = wibox.widget {
	{
		{
	icon,
	battery,
	spacing = dpi(1),
	layout = wibox.layout.fixed.horizontal,
		},
	left = dpi(5),
    right = 8,
    layout = wibox.container.margin,
	},
	forced_width = 73, --66,
	layout = wibox.layout.fixed.horizontal,
}

-- Update Function
local update_battery = function()
    local capacity =  io.popen("bat-asus-battery capacity"):read("*number")
	battery.markup = capacity.. "%"		
    local status = io.popen("bat-asus-battery status"):read("*line")
    if status == "Not charging" then
        icon.markup    = "<span foreground='"..beautiful.xcolor2.."'>󱟢 </span>"
    elseif status == "Charging" then
        icon.markup    = "<span foreground='"..beautiful.xcolor2.."'>󰂄 </span>"
    elseif status == "Discharging" then
        icon.markup    = "<span foreground='"..beautiful.xcolor2.."'>󰂀 </span>"
    else
        naughty.notify({
            title = 'Battery Wrong',
            text = status,
            timeout = 2
        })
    end

end
update_battery()

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        update_battery()
    end
}

return full

