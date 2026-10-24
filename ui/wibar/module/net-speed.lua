-------------------------------------------------
-- Net Speed Widget for Awesome Window Manager
-- Shows current upload/download speed
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/net-speed-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")

local net_speed_widget = {}

local function convert_to_h(bytes)
    local speed
    local dim
    if bytes < 1000 then
        speed = bytes
        dim = 'B/s'
    elseif bytes < 1000000 then
        speed = bytes / 1000
        dim = 'KB/s'
    elseif bytes < 1000000000 then
        speed = bytes / 1000000
        dim = 'MB/s'
    elseif bytes < 1000000000000 then
        speed = bytes / 1000000000
        dim = 'GB/s'
    else
        speed = tonumber(bytes)
        dim = 'B/s'
    end
    return math.floor(speed + 0.5) .. ' ' .. dim
end

local function split(string_to_split, separator)
    if separator == nil then separator = "%s" end
    local t = {}

    for str in string.gmatch(string_to_split, "([^" .. separator .. "]+)") do
        table.insert(t, str)
    end

    return t
end

local function worker(user_args)
    local args = user_args or {}

    local interface = args.interface or '*'
    local timeout = args.timeout or 1
    local width = args.width or 55

    net_speed_widget = wibox.widget {
        {
            id = 'rx_icon',
            font = beautiful.font .. " 12.5",
            align = 'center',
            markup = "<span foreground='" .. beautiful.xcolor2 .. "'> </span>",
            widget = wibox.widget.textbox
        },
        {
            id = 'rx_speed',
            forced_width = width,
            align = 'left',
            widget = wibox.widget.textbox
        },
        {
            id = 'tx_icon',
            font = beautiful.font .. " 12.5",
            align = 'center',
            markup = "<span foreground='" .. beautiful.xcolor2 .. "'> </span>",
            widget = wibox.widget.textbox
        },
        {
            id = 'tx_speed',
            forced_width = width,
            align = 'left',
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.horizontal,
        set_rx_text = function(self, new_rx_speed)
            self:get_children_by_id('rx_speed')[1]:set_text(tostring(new_rx_speed))
        end,
        set_tx_text = function(self, new_tx_speed)
            self:get_children_by_id('tx_speed')[1]:set_text(tostring(new_tx_speed))
        end
    }

    -- Set these to nil initially to detect the very first run
    local prev_rx = nil
    local prev_tx = nil

    local update_widget = function(widget, stdout)
        local cur_vals = split(stdout, '\r\n')

        local cur_rx = 0
        local cur_tx = 0

        for i, v in ipairs(cur_vals) do
            if i % 2 == 1 then cur_rx = cur_rx + v end
            if i % 2 == 0 then cur_tx = cur_tx + v end
        end

        -- If this is the first run, just capture the baseline data and display 0 B/s
        if prev_rx == nil or prev_tx == nil then
            prev_rx = cur_rx
            prev_tx = cur_tx
            widget:set_rx_text(convert_to_h(0))
            widget:set_tx_text(convert_to_h(0))
            return
        end

        local speed_rx = (cur_rx - prev_rx) / timeout
        local speed_tx = (cur_tx - prev_tx) / timeout

        widget:set_rx_text(convert_to_h(speed_rx))
        widget:set_tx_text(convert_to_h(speed_tx))

        prev_rx = cur_rx
        prev_tx = cur_tx
    end

    watch(string.format([[bash -c "cat /sys/class/net/%s/statistics/*_bytes"]], interface),
        timeout, update_widget, net_speed_widget)

    return net_speed_widget
end

return setmetatable(net_speed_widget, { __call = function(_, ...) return worker(...) end })
