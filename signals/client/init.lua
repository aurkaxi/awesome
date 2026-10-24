require 'awful.autofocus'
local gears = require 'gears'


client.connect_signal("property::fullscreen",
    function(c)
        c.shape = function(cr, w, h)
            if not c.fullscreen and not c.maximized then
                gears.shape.rounded_rect(cr, w, h, 15)
            else
                gears.shape.rounded_rect(cr, w, h, 0)
            end
        end
    end)


client.connect_signal('mouse::enter', function(c)
    c:activate { context = 'mouse_enter', raise = false }
end)
