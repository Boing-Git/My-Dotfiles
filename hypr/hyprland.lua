require("modules.misc")
require("modules.autostart")
require("modules.animations")
require("modules.deco")
require("modules.winrules")
require("modules.input")
require("modules.env")
require("modules.autostart")
require("modules.binds")
require("modules.general")
local variables = require("modules.variables")

if variables.Layout == "Scrolling" or variables.Layout == "scrolling" then
    require("modules.layouts.scrolling")
elseif variables.Layout == "Dwindle" or variables.Layout == "dwindle" then
    require("modules.layouts.dwindle")
elseif variables.Layout == "Master" or variables.Layout == "master" then
    require("modules.layouts.master")
elseif variables.Layout == "Monocle" or variables.Layout == "monocle" then
    require("modules.layouts.monocle")
end

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})
