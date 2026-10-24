local awful = require 'awful'
local ruled = require 'ruled'

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = {},
        except_any = { 'Conky' },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }

    ruled.notification.append_rule {
        rule_any = { class = { 'Conky' } },
        properties = {
            border_width = 0,
            below        = true,
        }
    }
end)
