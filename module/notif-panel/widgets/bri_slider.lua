local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

local slider = wibox.widget {
  bar_shape = helpers.ui.rrect(9),
  bar_height = 6,
  bar_color = beautiful.xcolorbase,
  bar_active_color = beautiful.xcolor7,
  handle_shape = gears.shape.circle,
  handle_color = beautiful.xcolor7,
  handle_width = 12,
  value = 25,
  forced_width = dpi(200),
  widget = wibox.widget.slider,
}

local bri_value = wibox.widget {
  text = "0%",
  font = beautiful.font .. "10",
  widget = wibox.widget.textbox(),
}

local icon = wibox.widget {
  markup = helpers.ui.colorize_text("󰃠 ", beautiful.xcolor7),
  font = beautiful.font .. " 14",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox(),
}

helpers.ui.add_hover_cursor(slider, "hand1")


local bri_slider = wibox.widget {
  {
    {
      layout = wibox.layout.fixed.horizontal,
      icon,
    },
    right = dpi(14),
    layout = wibox.container.margin
  },
  slider,
  layout = wibox.layout.fixed.horizontal,
  {
    {
      layout = wibox.layout.fixed.horizontal,
      bri_value,
    },
    left = dpi(20),
    layout = wibox.container.margin
  }
}

local update_brightness = function()  -- Sets the Brightness Correct
  local brightness_info = io.popen("brightnessctl get"):read("*all")
	slider.value = math.ceil(tonumber(brightness_info) * 100 / 255)
end

awesome.connect_signal("widget::update_bri", function()
  update_brightness()
end)

awesome.connect_signal("widget::update_bri_slider", function(bri_level)
  slider:set_value(bri_level)
end)

slider:connect_signal("property::value", function(_, new_value)
	awful.spawn("brightnessctl set " .. new_value .. "%", false)
	slider.value = new_value
  bri_value.text = new_value .. "%"
end)

return bri_slider
