-- Curves
hl.curve("jelly",     { type = "spring", mass = 1, stiffness = 150, dampening = 10 })
hl.curve("m3Standard",{ type = "bezier", points = { {0.2, 0}, {0, 1} } })

-- Base
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "m3Standard" })

-- Windows & Popins
hl.animation({ leaf = "windows",       enabled = true,  speed = 5,    spring = "jelly" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 5,    spring = "jelly", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4,    spring = "jelly", style = "popin 80%" })

-- Fades (Strictly Bezier)
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "m3Standard" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "m3Standard" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "m3Standard" })

-- Layers
hl.animation({ leaf = "layers",        enabled = true,  speed = 4,    spring = "jelly" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    spring = "jelly", style = "slide" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 3,    spring = "jelly", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "m3Standard" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "m3Standard" })

-- Workspaces
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4,    spring = "jelly", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4,    spring = "jelly", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 4,    spring = "jelly", style = "slide" })

-- Utility
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    spring = "jelly" })