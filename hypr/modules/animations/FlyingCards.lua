-- 1. Unique Asymmetrical Spring Profiles
-- The Slingshot: High tension, slight weight, deep rubber-band wobble
hl.curve("slingshotIn",  { type = "spring", mass = 1.2, stiffness = 180, dampening = 12 })
-- The Snap: Tight, snappy, heavily dampened to kill momentum fast
hl.curve("snapOut",      { type = "spring", mass = 1.0, stiffness = 250, dampening = 25 })
-- The Glide: Smooth but energetic horizontal movement
hl.curve("elasticGlide", { type = "spring", mass = 1.0, stiffness = 120, dampening = 16 })

-- 2. Base Fades (Strictly Bezier to prevent opacity flickering)
hl.curve("m3Standard",   { type = "bezier", points = { {0.2, 0}, {0, 1} } })

-- Base
hl.animation({ leaf = "global",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 4,  bezier = "m3Standard" })

-- Windows & Popins (The core Slingshot effect)
-- A deep 30% popin forces the spring to work harder, creating a massive visual overshoot
hl.animation({ leaf = "windows",       enabled = true, speed = 6, spring = "slingshotIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 6, spring = "slingshotIn", style = "popin 30%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 4, spring = "snapOut",     style = "popin 80%" })

-- Fades
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 2, bezier = "m3Standard" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 2, bezier = "m3Standard" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2, bezier = "m3Standard" })

-- Layers (App launchers, menus)
hl.animation({ leaf = "layers",        enabled = true, speed = 5, spring = "elasticGlide" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 5, spring = "elasticGlide", style = "slide" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 4, spring = "snapOut",      style = "slide" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 2, bezier = "m3Standard" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "m3Standard" })

-- Workspaces (Slidefade gives a deep, dimensional transition)
hl.animation({ leaf = "workspaces",    enabled = true, speed = 5, spring = "elasticGlide", style = "slidefade 30%" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 5, spring = "elasticGlide", style = "slidefade 30%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, spring = "elasticGlide", style = "slidefade 30%" })

-- Utility
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 5, spring = "elasticGlide" })