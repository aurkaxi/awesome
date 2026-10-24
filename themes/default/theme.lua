---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "/home/aurka/.config/awesome/themes/"
local helpers = require ("helpers")
local theme = {}


-- Transparent Color --
theme.transparent = "#00000000"

-- Base -- 
theme.xcolorcrust = "#11111b"
theme.xcolormantle = "#181825"
theme.xcolorbase = "#1E1E2E"


-- Surface --
theme.xcolorS0 = "#313244"
theme.xcolorS1 = "#45475a"
theme.xcolorS2 = "#585b70"

-- Overlay --
theme.xcolorO0 = "#6c7086"
theme.xcolorO1 = "#7f849c"
theme.xcolorO2 = "#585b70"

-- Text --
theme.xcolorT0 = "#a6adc8"
theme.xcolorT1 = "#bac2de"
theme.xcolorT2 = "#cdd6f4"

-- Lavender --
theme.xcolor1 = "#b4befe"
-- Blue --
theme.xcolor2 = "#89b4fa"
-- Sapphire --
theme.xcolor3 = "#74c7ec"
-- Sky --
theme.xcolor4 = "#89dceb"
-- Teal -- 
theme.xcolor5 = "#94e2d5"
-- Green --
theme.xcolor6 = "#a6e3a1"
-- Yellow --
theme.xcolor7 = "#f9e2af"
-- Peach --
theme.xcolor8 = "#fab387"
-- Maroon --
theme.xcolor9 = "#eba0ac"
-- Red --
theme.xcolor10 = "#f38ba8"
-- Mauve --
theme.xcolor11 = "#cba6f7"
-- Pink --
theme.xcolor12 = "#f5c2e7"
-- Flamingo --
theme.xcolor13 = "#f2cdcd"
-- Rosewater --
theme.xcolor14 = "#f5e0dc"

theme.music = themes_path.."default/assets/music.png"
theme.volume_on = themes_path.."default/assets/volume-on.png"
theme.volume_off = themes_path.."default/assets/volume-off.png"
theme.pfp = themes_path.."default/assets/pfp.jpg"

theme.font          = "FiraCode Nerd Font 9 "
theme.font_name     = "FiraCode Nerd Font "
theme.bg_normal     = "#1e1e2e"
theme.bg_focus      = "#313244"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#cdd6f4"
theme.fg_focus      = "#94e2d5"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap         = dpi(5)
theme.border_width        = dpi(3)
theme.border_color_normal = "#313244"
theme.border_color_active = "#94e2d5"
theme.border_color_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
theme.taglist_spacing   = dpi(2)
theme.taglist_bg_focus  = "#1e1e2e"
theme.taglist_disable_icon = true
theme.taglist_fg_focus  = "#89b4fa"
theme.taglist_fg_empty  = "#585b70"
theme.taglist_fg_occupied   = "#526c96"
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_bg_focus = "#1e1e2e"
theme.tasklist_fg_focus = "#b4befe"
theme.tasklist_disable_icon = true
-- titlebar_[bg|fg]_[normal|focus]
theme.titlebar_bg_focus  = "#1e1e2e"
theme.titlebar_bg_normal = "#1e1e2e"
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.hotkeys_shape = helpers.ui.rrect(12)
theme.hotkeys_border_color = "#9432d5"
theme.hotkeys_modifiers_fg = "#585b70"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, "#89b4fa"
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.taglist_fg_occupied
)


-- Variables set for theming notifications:
-- notification_font
theme.notification_spacing = dpi(4)
-- notification_[bg|fg]
theme.notification_bg = "#1e1e2e"
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
theme.menu_bg_focus = "#1e1e2e"
theme.menu_fg_focus = "#89b4fa"
theme.menu_border_width = dpi(2)
theme.menu_border_color = "#313244"
-- theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.submenu = "»  "
theme.menu_height = dpi(30)
theme.menu_width  = dpi(150)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/unfocus.svg"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close.svg"
theme.titlebar_close_button_focus_hover = themes_path.."default/titlebar/close_hover.svg"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/unfocus.svg"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize.svg"
theme.titlebar_minimize_button_focus_hover = themes_path.."default/titlebar/minimize_hover.svg"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/unfocus.svg"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop.svg"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/unfocus.svg"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop.svg"
theme.titlebar_ontop_button_focus_inactive_hover = themes_path .. "default/titlebar/ontop_hover.svg"
theme.titlebar_ontop_button_focus_active_hover = themes_path .. "default/titlebar/ontop_hover.svg"

theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/unfocus.svg"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_active_hover = themes_path.."default/titlebar/maximize_hover.svg"
theme.titlebar_maximized_button_focus_active_hover = themes_path.."default/titlebar/maximize_hover.svg"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/unfocus.svg"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_inactive_hover = themes_path.."default/titlebar/maximize_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = themes_path.."default/titlebar/maximize_hover.svg"



-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floating.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/max.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tile.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"
theme.layout_centered = themes_path.."default/layouts/centered.png"
theme.layout_mstab = themes_path.."default/layouts/mstab.png"
theme.layout_equalarea = themes_path.."default/layouts/equalarea.png"
theme.layout_machi = themes_path.."default/layouts/machi.png"
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Flat-Remix-Grey-Dark"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
