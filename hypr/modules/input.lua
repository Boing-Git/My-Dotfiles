
---------------
---- INPUT ----
---------------
local vars = require("modules.variables")

hl.config({
    input = {
        kb_layout  = vars.kb_layout,
        kb_options = vars.kb_options,

        follow_mouse = vars.follow_mouse,

        sensitivity = vars.sensitivity, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = vars.touchpad_natural_scroll,
        },
    },
})

hl.gesture({
    fingers = vars.gesture_fingers,
    direction = vars.gesture_direction,
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
