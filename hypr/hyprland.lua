local hl = hl
-- MONITORS

-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor({
    output = "",
    mode = "1920x1080",
    position = "auto",
    scale = 1
})
hl.monitor({
    output = "DP-2",
    mode = "1920x1080",
    position = "0x0",
    scale = 1
})

-- VARIABLES
local terminal = "alacritty"
local menu = "$(tofi-drun --font monospace)"
local mainMod = "ALT"
local modPlus = mainMod .. " + "


-- AUTOSTART
hl.on("hyprland.start", function()
    hl.exec_cmd("syncthing")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("kdeconnectd")
    hl.exec_cmd("kde-connect-indicator")
    hl.exec_cmd("hyprpaper")
end)

-- ENVIRONMENT VARIABLES
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-- LOOK AND FEEL
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 15,
        border_size = 1,
        col = {
            active_border = "rgba(33ccffee)",
            inactive_border = "rgba(000000ee)"
        },
        -- resize_on_border = false
        allow_tearing = false,
        layout = "dwindle"
    },
    decoration = {
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = false
        }
    },
    dwindle = {
        force_split = 0,
        preserve_split = true

    },
    animations = {
        enabled = false
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        scroll_factor = 0.6,
        -- sensitivity = 0.3,
        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.5
        }
    },
    gestures = {
        workspace_swipe_touch = true
    },
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
    }
})

-- KEYBINDINGSS

hl.bind(modPlus .. "RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(modPlus .. "Q", hl.dsp.window.close())
hl.bind(modPlus .. "SHIFT + Q", hl.dsp.window.kill())
hl.bind(modPlus .. "SPACE", hl.dsp.window.float({action = "toggle"}))
hl.bind(modPlus .. "D", hl.dsp.exec_cmd(menu))
hl.bind(modPlus .. "F", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))

-- Move focus with mainMod + vim keys
hl.bind(modPlus .. "H", hl.dsp.focus({direction = "l"}))
hl.bind(modPlus .. "L", hl.dsp.focus({direction = "r"}))
hl.bind(modPlus .. "K", hl.dsp.focus({direction = "u"}))
hl.bind(modPlus .. "J", hl.dsp.focus({direction = "d"}))

-- Move placement with mainMod + vim keys
hl.bind(modPlus .. "SHIFT + H", hl.dsp.window.move({direction = "l"}))
hl.bind(modPlus .. "SHIFT + L", hl.dsp.window.move({direction = "r"}))
hl.bind(modPlus .. "SHIFT + K", hl.dsp.window.move({direction = "u"}))
hl.bind(modPlus .. "SHIFT + J", hl.dsp.window.move({direction = "d"}))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(modPlus .. key, hl.dsp.focus({workspace = i}))
    hl.bind(modPlus .. "SHIFT + " .. key, hl.dsp.window.move({workspace = i}))
end

-- Example special workspace (scratchpad)
hl.bind(modPlus .. "SHIFT + Minus", hl.dsp.window.move({workspace = "special:special"}))
hl.bind(modPlus .. "Minus", hl.dsp.workspace.toggle_special({"special"}))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(modPlus .. "mouse_down", hl.dsp.focus({workspace = "e-1"}))
hl.bind(modPlus .. "mouse_up", hl.dsp.focus({workspace = "e+1"}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(modPlus .. "mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind(modPlus .. "mouse:273", hl.dsp.window.resize(), {mouse = true})

-- Screenshots
hl.bind(modPlus .. "P", hl.dsp.exec_cmd("grim -g \"$(slurp)\" -t png ~/\"screenshot$(date +'%T').png\""))

-- Brightness Controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +15%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 15%-"))

-- Audio Controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +2%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -2%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
