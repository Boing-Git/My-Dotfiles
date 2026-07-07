-- Relaxed Animation Style
hl.curve("relaxedCurve", { type = "bezier", points = { {0.4, 0.1}, {0.1, 0.9} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5, bezier = "relaxedCurve" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 4.5, bezier = "relaxedCurve" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.5,  bezier = "relaxedCurve", style = "popin 90%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4, bezier = "relaxedCurve", style = "popin 90%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 3.5, bezier = "relaxedCurve" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 3.5, bezier = "relaxedCurve" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.5, bezier = "relaxedCurve" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 4, bezier = "relaxedCurve" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "relaxedCurve", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 3.5,  bezier = "relaxedCurve", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 3, bezier = "relaxedCurve" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 3, bezier = "relaxedCurve" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4, bezier = "relaxedCurve", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4, bezier = "relaxedCurve", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 4, bezier = "relaxedCurve", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    bezier = "relaxedCurve" })
