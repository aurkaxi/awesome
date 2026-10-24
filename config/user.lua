local awful = require 'awful'
local bling = require 'module.bling'
local machi = require 'module.layout-machi'

return {
    layouts = {
        -- left column, right dice same size
        awful.layout.suit.tile,

        -- left big colum, smaller dice each time
        awful.layout.suit.spiral.dwindle,

        -- focus in middle front, everything else in background
        awful.layout.suit.magnifier,

        -- left-up corner big, else small
        awful.layout.suit.corner.nw,

        -- equal size column
        awful.layout.suit.fair,

        -- fullscreen all app
        awful.layout.suit.max.fullscreen,

        -- one big center column, right-left small column
        bling.layout.centered,

        -- big column, right column = stack of all windows + one of them
        bling.layout.mstab,

        -- all window same area mathmatically
        bling.layout.equalarea,

        machi.layout.create { new_placement_cb = machi.layout.placement.empty },
        -- awful.layout.suit.floating,           -- 16:
    },



    tags = { '1', '2', '3', '4', '5', '6', '7', '8', '9' },

    widget = {
        weather = {
            key = "",
            coordinates = {
                "REDACTED",
                "REDACTED",
            }
        },
        github = {
            username = "aurkaxi"
        },
        mic = {
            name = ""
        },
        disk = {
            name = "/dev/nvme0n1p3"
        },

    },
}
