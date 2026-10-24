local awful = require "awful"

local tomato = awful.widget.watch("tomato -t", 1, function(widget, stdout)
    widget:set_markup(stdout)
end)

return tomato