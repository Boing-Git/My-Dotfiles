-- Cinematic Animation Style (Slow and majestic)
hl.curve("cinematicIn", { type = "bezier", points = { {0.2, 0}, {0, 1} } })
hl.curve("cinematicOut", { type = "bezier", points = { {1, 0}, {0.8, 1} } })
hl.curve("cinematicStandard", { type = "bezier", points = { {0.5, 0}, {0.5, 1} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 8, bezier = "cinematicStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 7, bezier = "cinematicIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 7,  bezier = "cinematicIn", style = "popin 95%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 6, bezier = "cinematicOut", style = "popin 95%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 6, bezier = "cinematicIn" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 6, bezier = "cinematicOut" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 6, bezier = "cinematicStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 7, bezier = "cinematicStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 7,    bezier = "cinematicIn", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 6,  bezier = "cinematicOut", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 5, bezier = "cinematicIn" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 5, bezier = "cinematicOut" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 6, bezier = "cinematicIn", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 6, bezier = "cinematicIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 6, bezier = "cinematicOut", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 8,    bezier = "cinematicStandard" })
