-- Aggressive Animation Style (Sharp, abrupt motions)
hl.curve("aggroIn", { type = "bezier", points = { {0.1, 1}, {0.2, 1.1} } })
hl.curve("aggroOut", { type = "bezier", points = { {0.9, -0.1}, {1, 0} } })
hl.curve("aggroStandard", { type = "bezier", points = { {1, 0}, {0, 1} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 2, bezier = "aggroStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 2, bezier = "aggroIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2,  bezier = "aggroIn", style = "popin 95%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.5, bezier = "aggroOut", style = "popin 95%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.5, bezier = "aggroIn" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.5, bezier = "aggroOut" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 1.5, bezier = "aggroStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 2, bezier = "aggroStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2,    bezier = "aggroIn", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "aggroOut", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.5, bezier = "aggroIn" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.5, bezier = "aggroOut" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2, bezier = "aggroIn", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2, bezier = "aggroIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.5, bezier = "aggroOut", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 2,    bezier = "aggroStandard" })
