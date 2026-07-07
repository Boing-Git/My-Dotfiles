-- 1. Spring Physics Curves (For Movement)
-- Lower dampening relative to stiffness creates more "bounce"
hl.curve("springBouncy", { type = "spring", mass = 1, stiffness = 100, dampening = 10 }) -- Very elastic, noticeable bounce
hl.curve("springSnappy", { type = "spring", mass = 1, stiffness = 130, dampening = 14 }) -- Fast, tight snap with a subtle wobble
hl.curve("springGentle", { type = "spring", mass = 1, stiffness = 80,  dampening = 12 }) -- Softer, more relaxed bounce

-- 2. Material 3 Beziers (Kept specifically for Fades)
hl.curve("m3Standard",        { type = "bezier", points = { {0.2, 0}, {0, 1} } })
hl.curve("m3StandardDecel",   { type = "bezier", points = { {0, 0}, {0, 1} } })
hl.curve("m3StandardAccel",   { type = "bezier", points = { {0.3, 0}, {1, 1} } })


-- Animations mapped to springs for movement, beziers for fades
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "m3Standard" })

-- Windows & Popins (Using springBouncy for maximum expression)
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "springBouncy" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "springBouncy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, spring = "springSnappy", style = "popin 87%" })

-- Fades (Strictly Bezier)
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "m3StandardDecel" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "m3StandardAccel" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "m3Standard" })

-- Layers (Menus, app launchers - gentle bounce)
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, spring = "springGentle" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    spring = "springGentle", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  spring = "springSnappy", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "m3StandardDecel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "m3StandardAccel" })

-- Workspaces (Snappy horizontal movement with slight elasticity)
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, spring = "springSnappy", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, spring = "springSnappy", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, spring = "springSnappy", style = "slide" })

-- Utility
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    spring = "springGentle" })