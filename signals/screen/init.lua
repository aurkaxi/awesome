local awful = require 'awful'
local wibox = require("wibox")

-- FIXED wallpaper
local path = os.getenv("HOME") .. "/Pictures/Wallpapers/fixed_wall.png"

screen.connect_signal('request::wallpaper', function(s)
    awful.wallpaper({
        screen = s,
        widget = {
            widget = wibox.container.tile,
            valign = 'center',
            halign = 'center',
            tiled  = false,
            {
                widget    = wibox.widget.imagebox,
                -- image       = beautiful.wallpaper,
                image     = path,
                upscale   = true,
                downscale = true
            }
        }
    })
end)
