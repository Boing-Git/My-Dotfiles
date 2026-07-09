
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local vars = require("modules.variables")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", vars.env_xcursor_size)
hl.env("HYPRCURSOR_SIZE", vars.env_hyprcursor_size)
hl.env("XCURSOR_THEME", vars.cursor_theme)
hl.env("HYPRCURSOR_THEME", vars.cursor_theme)
hl.env("QT_SCALE_FACTOR", vars.env_qt_scale_factor)
