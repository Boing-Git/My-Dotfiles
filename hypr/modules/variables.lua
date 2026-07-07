----------------------------------------------------------------------------------------
--- These variables will be used in various locations in the hypr config so set them ---
----------------------------------------------------------------------------------------

local vars = {
-------------------------------------------------------------------------------------------------------------------------------------
----One thing to note that add the command for the app not the name, Sometimes the name of the app differs from the app command----
-------------------------------------------------------------------------------------------------------------------------------------

    Term = "wezterm", -- Set the terminal emulator --
    Browser = "zen-beta", -- Set the browser --
    Editor = "antigravity", -- Set the code editor --
    Files = "nautilus", -- Set the file explorer --
    SysInfo = "btop", -- Set the system info app name/command (e.g., "btop" or "gnome-system-monitor") --

    -- Select between these layouts for window management, These are non-case sensitive --
    -- Scrolling
    -- Dwindle
    -- Master
    -- Monocle
    Layout = "Scrolling",

---------------------
-- Enable vim keys --
---------------------

    singleWindowGapsOut = 10, -- Modify this to or set this 0 for no gaps or add more gaps around the windows but this only works when there is only a single window --

-----------------------------
---Select animations style---
-----------------------------

    -- Select Animation style and all the animations styles, These are non-case sensitive--
    -- Expressive  -- Simple but elegant (Material 3 Defaults)
    -- Springy     -- Simple springy motions
    -- Jelly       -- Highly elastic and springy
    -- FlyingCards -- Simple workspace motion but springy in window motion
    -- Snappy      -- Very fast and responsive, quick pop-ins
    -- Cinematic   -- Slow, majestic, and smooth for a dramatic feel
    -- Fluid       -- Continuous, smooth, liquid-like symmetrical curves
    -- Playful     -- Bouncy with subtle overshoots and anticipation
    -- Elegant     -- Soft, long, smooth easing for a highly premium feel
    -- Minimal     -- Extremely subtle utility animations with minimal sliding
    -- Aggressive  -- Sharp, abrupt motions with aggressive curves
    -- Elastic     -- Exaggerated elasticity with high bezier overshoots
    -- Swift       -- Linear but highly accelerated, no wasted time
    -- Relaxed     -- Slow, gradual, and completely unhurried
    -- slipStream  -- Smooth, windy sliding animations
    -- Standard    -- Standard, smooth Material-like animations
    -- Fluent      -- Comprehensive fluent design animations
    -- None        -- Disables all animations
    AnimateStyle = "slipStream",

    --Set true if you want group bars on groups--
    groupBar = true,

    --Set Wallpaper switch keys--

    -----------------------
    ---- DECORATIONS   ----
    -----------------------
    gaps_in = 5, -- Gaps between windows
    gaps_out = 10, -- Gaps between windows and monitor edges
    border_size = 3, -- Size of the window borders
    rounding = 35, -- Rounding of window corners
    rounding_power = 6, -- Rounding power (how smooth the curve is)
    active_opacity = 0.9, -- Opacity of the focused window
    inactive_opacity = 0.7, -- Opacity of unfocused windows
    shadow_enabled = true, -- Enable or disable drop shadows
    shadow_range = 16, -- Size of the shadow
    shadow_render_power = 1, -- How fast the shadow fades
    blur_enabled = true, -- Enable or disable background blur
    blur_size = 6, -- Size of the blur effect
    blur_passes = 3, -- Number of blur passes
    blur_vibrancy = 0.5, -- Increase saturation of blurred colors

    -----------------------
    ---- GENERAL       ----
    -----------------------
    resize_on_border = true, -- Enable resizing windows by clicking/dragging borders
    allow_tearing = true, -- Allow screen tearing (good for gaming, lowers latency)

    -----------------------
    ---- INPUT         ----
    -----------------------
    kb_layout = "us", -- Keyboard layout (e.g., "us", "uk", "fr")
    kb_options = "caps:escape", -- Keyboard options (e.g., swapping caps/esc)
    follow_mouse = 1, -- Window focus follows mouse (0 = disabled, 1 = enabled, etc.)
    sensitivity = 0, -- Mouse sensitivity (-1.0 to 1.0, 0 is unmodified)
    touchpad_natural_scroll = false, -- Enable natural scrolling on touchpads
    gesture_fingers = 3, -- Number of fingers for workspace swipe gesture
    gesture_direction = "horizontal", -- Direction of the workspace swipe ("horizontal" or "vertical")

    -----------------------
    ---- MISCELLANEOUS ----
    -----------------------
    force_default_wallpaper = -1, -- Force the default anime wallpaper (-1 = auto, 0 = disable)
    disable_hyprland_logo = false, -- Disable the Hyprland logo on the background
    allow_session_lock_restore = 1, -- Allow session lock to be restored
    vrr = 1, -- Variable Refresh Rate (0 = off, 1 = on, 2 = fullscreen only)
    xwayland_force_zero_scaling = true, -- Force XWayland apps to 1x scale (prevents blurriness)
    xwayland_use_nearest_neighbor = false, -- Use nearest neighbor filtering for XWayland

    -----------------------
    ---- ENVIRONMENT   ----
    -----------------------
    env_xcursor_size = "24", -- XCursor size
    env_hyprcursor_size = "24", -- Hyprcursor size
    env_qt_scale_factor = "1" -- QT scale factor
}

----------------------------------------------------------------------------------------
-- Special thanks to these people/projects for all of these animation styles:
-- https://github.com/ArtemSmaznov/dotfiles-hyprland/tree/master
-- https://github.com/notcandy001/Moonveil/blob/master/dots/.config/hypr/modules/animations.lua
-- https://github.com/caelestia-dots/shell
----------------------------------------------------------------------------------------

return vars
