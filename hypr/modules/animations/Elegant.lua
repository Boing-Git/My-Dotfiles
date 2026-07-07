-- Elegant Animation Style (Soft, long smooth easing)
hl.curve("elegantIn", { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })
hl.curve("elegantOut", { type = "bezier", points = { {0.5, 0}, {0.75, 0} } })
hl.curve("elegantStandard", { type = "bezier", points = { {0.6, 0.05}, {0.05, 0.9} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 6, bezier = "elegantStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 5, bezier = "elegantIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 5,  bezier = "elegantIn", style = "popin 92%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4, bezier = "elegantOut", style = "popin 92%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 4, bezier = "elegantIn" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 4, bezier = "elegantOut" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 4, bezier = "elegantStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 5, bezier = "elegantStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 5,    bezier = "elegantIn", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 4,  bezier = "elegantOut", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 3.5, bezier = "elegantIn" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 3.5, bezier = "elegantOut" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 5, bezier = "elegantIn", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 5, bezier = "elegantIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 4, bezier = "elegantOut", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 6,    bezier = "elegantStandard" })
