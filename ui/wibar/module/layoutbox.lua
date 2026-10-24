local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"

awful.screen.connect_for_each_screen(function(s)
    s.layoutbox = awful.widget.layoutbox {
        screen = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }
end)

-- local layoutbox = awful.widget.layoutbox ({
--     buttons = {
--         awful.button({ }, 1, function () awful.layout.inc( 1) end),
--         awful.button({ }, 3, function () awful.layout.inc(-1) end),
--         awful.button({ }, 4, function () awful.layout.inc(-1) end),
--         awful.button({ }, 5, function () awful.layout.inc( 1) end),
--     }
-- })
-- return layoutbox